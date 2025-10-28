import 'dart:async';
import 'dart:io';

import 'package:attendify/features/advertising/domain/entities/advertising_result.dart';
import 'package:attendify/features/advertising/domain/entities/advertising_state.dart';
import 'package:attendify/features/advertising/domain/repositories/advertising_repository.dart';
import 'package:attendify/features/scanning/domain/entities/bluetooth_state.dart'
    as domain;
import 'package:bluetooth_low_energy/bluetooth_low_energy.dart' as ble;
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import 'package:permission_handler/permission_handler.dart';

class AdvertisingRepositoryImpl implements AdvertisingRepository {
  AdvertisingRepositoryImpl() {
    _peripheral = ble.PeripheralManager();
    _advertisingStateController =
        StreamController<AdvertisingState>.broadcast();
  }

  late final ble.PeripheralManager _peripheral;
  late final StreamController<AdvertisingState> _advertisingStateController;
  AdvertisingState _currentState = AdvertisingState.idle;
  bool _loggingEnabled = false;

  void _log(final String message) {
    if (_loggingEnabled) {
      print('[ADVERTISING] $message');
    }
  }

  void _updateState(final AdvertisingState newState) {
    if (_currentState != newState) {
      _currentState = newState;
      _advertisingStateController.add(newState);
      _log('State changed to: $newState');
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

  // === Состояние Advertising ===

  @override
  Future<AdvertisingState> get advertisingState async => _currentState;

  @override
  Stream<AdvertisingState> get advertisingStateStream =>
      _advertisingStateController.stream;

  // === Advertising ===

  @override
  Future<AdvertisingResult> startAdvertising({
    required final String serviceUuid,
    final String? deviceName,
  }) async {
    try {
      if (!_currentState.canStart) {
        return AdvertisingError(
          'Cannot start advertising in state: $_currentState',
        );
      }

      _updateState(AdvertisingState.starting);
      _log('Starting advertising with UUID from API: $serviceUuid');

      await checkAndRequestPermissions(); // Просто запрашиваем, не проверяем результат как в рабочем коде

      // Авторизация для Android (как в рабочем коде)
      if (Platform.isAndroid) {
        try {
          final authorized = await _peripheral.authorize();
          if (!authorized) {
            _updateState(AdvertisingState.error);
            return const AdvertisingError('BLE authorization denied');
          }
        } catch (e) {
          _log('Authorization error: $e');
          _updateState(AdvertisingState.error);
          return const AdvertisingError('BLE authorization failed');
        }
      }

      final finalDeviceName = deviceName ?? 'AttendifyUser';
      final advertisement = ble.Advertisement(
        name: finalDeviceName,
        serviceUUIDs: [ble.UUID.fromString(serviceUuid)],
      );

      // Ждем готовности Bluetooth (особенно важно для iOS)
      if (Platform.isIOS) {
        // На iOS обязательно ждать включения Bluetooth
        if (_peripheral.state != ble.BluetoothLowEnergyState.poweredOn) {
          _log('Waiting for Bluetooth to be powered on...');
          await for (final stateChange in _peripheral.stateChanged) {
            _log('BLE state changed to: ${stateChange.state}');
            if (stateChange.state == ble.BluetoothLowEnergyState.poweredOn) {
              break;
            }
          }
        }
      }

      await Future.delayed(const Duration(milliseconds: 500));
      await _peripheral.startAdvertising(advertisement);

      _updateState(AdvertisingState.active);
      _log('Advertising started successfully');

      return AdvertisingStarted(serviceUuid, finalDeviceName);
    } catch (e) {
      _updateState(AdvertisingState.error);
      _log('Error starting advertising: $e');
      return AdvertisingError(
        'Failed to start advertising: $e',
        e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<AdvertisingResult> stopAdvertising() async {
    try {
      if (!_currentState.canStop && _currentState != AdvertisingState.error) {
        return AdvertisingError(
          'Cannot stop advertising in state: $_currentState',
        );
      }

      _updateState(AdvertisingState.stopping);
      _log('Stopping advertising');

      await Future.delayed(const Duration(milliseconds: 500));
      await _peripheral.stopAdvertising();

      _updateState(AdvertisingState.idle);
      _log('Advertising stopped');

      return const AdvertisingStopped();
    } catch (e) {
      _updateState(AdvertisingState.error);
      _log('Error stopping advertising: $e');
      return AdvertisingError(
        'Failed to stop advertising: $e',
        e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<bool> get isAdvertising async => _currentState.isActive;

  // === Утилиты ===

  @override
  Future<void> reset() async {
    try {
      if (_currentState.isActive) {
        await stopAdvertising();
      }
      _updateState(AdvertisingState.idle);
      _log('Advertising repository reset completed');
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

  Future<void> dispose() async {
    await _advertisingStateController.close();
  }
}
