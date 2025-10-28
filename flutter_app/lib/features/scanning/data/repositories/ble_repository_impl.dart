import 'dart:async';
import 'dart:io';

import 'package:attendify/features/scanning/domain/entities/ble_device.dart';
import 'package:attendify/features/scanning/domain/entities/ble_scan_result.dart';
import 'package:attendify/features/scanning/domain/entities/bluetooth_state.dart'
    as domain;
import 'package:attendify/features/scanning/domain/repositories/ble_repository.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import 'package:permission_handler/permission_handler.dart';

class BleRepositoryImpl implements BleRepository {
  StreamController<BleScanResult>? _scanController;
  bool _loggingEnabled = false;

  void _log(final String message) {
    if (_loggingEnabled) {
      print('[BLE] $message');
    }
  }

  // === Управление разрешениями ===

  @override
  Future<bool> checkAndRequestPermissions() async {
    try {
      await [
        Permission.bluetoothScan,
        Permission.bluetoothAdvertise,
        Permission.bluetoothConnect,
        Permission.location,
      ].request();

      return true; // В рабочем коде не проверяли статус, просто запрашивали
    } catch (e) {
      _log('Error requesting permissions: $e');
      return false;
    }
  }

  // === Состояние Bluetooth ===

  @override
  Future<domain.BluetoothState> get bluetoothState async {
    final state = await fbp.FlutterBluePlus.adapterState.first;
    return _mapBluetoothState(state);
  }

  @override
  Stream<domain.BluetoothState> get bluetoothStateStream =>
      fbp.FlutterBluePlus.adapterState.map(_mapBluetoothState);

  domain.BluetoothState _mapBluetoothState(
    final fbp.BluetoothAdapterState state,
  ) {
    switch (state) {
      case fbp.BluetoothAdapterState.on:
        return domain.BluetoothState.on;
      case fbp.BluetoothAdapterState.off:
        return domain.BluetoothState.off;
      case fbp.BluetoothAdapterState.turningOn:
        return domain.BluetoothState.turningOn;
      case fbp.BluetoothAdapterState.turningOff:
        return domain.BluetoothState.turningOff;
      case fbp.BluetoothAdapterState.unavailable:
        return domain.BluetoothState.unavailable;
      case fbp.BluetoothAdapterState.unauthorized:
        return domain.BluetoothState.unavailable;
      case fbp.BluetoothAdapterState.unknown:
        return domain.BluetoothState.unknown;
    }
  }

  // === Сканирование устройств ===

  @override
  Future<List<BleDevice>> scanForDevices({
    final String? serviceUuid,
    final Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      _log(
        'Starting scan${serviceUuid != null ? ' for service UUID from API: $serviceUuid' : ' for all devices'}',
      );

      // Запрашиваем разрешения (как в рабочем коде)
      await checkAndRequestPermissions();

      // Проверяем состояние Bluetooth (особенно важно для iOS)
      if (Platform.isIOS) {
        // На iOS обязательно ждать включения Bluetooth
        fbp.BluetoothAdapterState adapterState =
            await fbp.FlutterBluePlus.adapterState.first;
        while (adapterState != fbp.BluetoothAdapterState.on) {
          _log('Waiting for Bluetooth to be turned on...');
          await Future.delayed(const Duration(milliseconds: 300));
          adapterState = await fbp.FlutterBluePlus.adapterState.first;
        }
      }

      final btState = await bluetoothState;
      if (!btState.canScan) {
        throw Exception('Bluetooth is not ready: $btState');
      }

      // Останавливаем предыдущее сканирование если было
      final isAlreadyScanning = await fbp.FlutterBluePlus.isScanning.first;
      if (isAlreadyScanning) {
        _log('Scan already in progress, stopping first');
        await fbp.FlutterBluePlus.stopScan();
      }

      // Запускаем сканирование
      await fbp.FlutterBluePlus.startScan(timeout: timeout);

      // Ждем завершения сканирования
      await Future.delayed(timeout);

      // Получаем результаты
      final results = await fbp.FlutterBluePlus.scanResults.first;

      List<BleDevice> devices;
      if (serviceUuid != null && serviceUuid.isNotEmpty) {
        devices = results
            .where((final result) {
              final uuids = result.advertisementData.serviceUuids.map(
                (final g) => g.toString().toLowerCase(),
              );
              return uuids.contains(serviceUuid.toLowerCase());
            })
            .map(_mapScanResultToDevice)
            .toList();
      } else {
        devices = results.map(_mapScanResultToDevice).toList();
      }

      await stopScan();
      _log('Scan completed, found ${devices.length} devices');

      return devices;
    } catch (e) {
      _log('Scan error: $e');
      await stopScan();
      rethrow;
    }
  }

  BleDevice _mapScanResultToDevice(final fbp.ScanResult result) => BleDevice(
    id: result.device.remoteId.toString(),
    name: result.device.platformName,
    rssi: result.rssi,
    serviceUuids: result.advertisementData.serviceUuids
        .map((final uuid) => uuid.toString())
        .toList(),
    advertisementData: {
      'localName': result.advertisementData.advName,
      'txPowerLevel': result.advertisementData.txPowerLevel,
      'connectable': result.advertisementData.connectable,
      'manufacturerData': result.advertisementData.manufacturerData,
    },
  );

  @override
  Future<void> stopScan() async {
    try {
      await fbp.FlutterBluePlus.stopScan();
      // Состояние BleScanIdle будет добавлено автоматически через listener
      await _scanController?.close();
      _scanController = null;
      _log('Scan stopped');
    } catch (e) {
      _log('Error stopping scan: $e');
    }
  }

  @override
  Future<bool> get isScanning => fbp.FlutterBluePlus.isScanning.first;

  // === Утилиты ===

  @override
  Future<void> reset() async {
    try {
      await stopScan();
      _log('BLE scanning repository reset completed');
    } catch (e) {
      _log('Error during reset: $e');
      rethrow;
    }
  }

  @override
  void setLoggingEnabled(final bool enabled) {
    _loggingEnabled = enabled;
    _log('Logging ${enabled ? 'enabled' : 'disabled'}');
  }
}
