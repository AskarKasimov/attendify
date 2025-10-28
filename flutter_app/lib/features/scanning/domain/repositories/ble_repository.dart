import 'package:attendify/features/scanning/domain/entities/ble_device.dart';
import 'package:attendify/features/scanning/domain/entities/bluetooth_state.dart';

/// Абстракция для работы с BLE сканированием
/// UUID для поиска будет приходить из API
abstract class BleRepository {
  /// Проверяет и запрашивает необходимые разрешения
  Future<bool> checkAndRequestPermissions();

  /// Получить текущее состояние Bluetooth
  Future<BluetoothState> get bluetoothState;

  /// Поток изменений состояния Bluetooth
  Stream<BluetoothState> get bluetoothStateStream;

  /// Сканировать устройства с определенным UUID сервиса
  /// [serviceUuid] - UUID сервиса, который придет из API. Если не указан, сканируются все устройства
  /// Возвращает список найденных устройств
  Future<List<BleDevice>> scanForDevices({
    String? serviceUuid,
    final Duration timeout = const Duration(seconds: 10),
  });

  /// Остановить сканирование
  Future<void> stopScan();

  /// Проверить, активно ли сканирование
  Future<bool> get isScanning;

  /// Сбросить состояние репозитория
  Future<void> reset();

  /// Включить/выключить логирование
  void setLoggingEnabled(final bool enabled);
}
