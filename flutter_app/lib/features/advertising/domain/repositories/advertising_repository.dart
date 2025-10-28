import 'package:attendify/features/advertising/domain/entities/advertising_result.dart';
import 'package:attendify/features/advertising/domain/entities/advertising_state.dart';
import 'package:attendify/features/scanning/domain/entities/bluetooth_state.dart';

/// Абстракция для BLE advertising (рекламирования устройства)
abstract class AdvertisingRepository {
  /// Проверяет и запрашивает необходимые разрешения для advertising
  Future<bool> checkAndRequestPermissions();

  /// Получить текущее состояние Bluetooth
  Future<BluetoothState> get bluetoothState;

  /// Поток изменений состояния Bluetooth
  Stream<BluetoothState> get bluetoothStateStream;

  /// Получить текущее состояние advertising
  Future<AdvertisingState> get advertisingState;

  /// Поток изменений состояния advertising
  Stream<AdvertisingState> get advertisingStateStream;

  /// Начать advertising с UUID из API
  /// [serviceUuid] - UUID сервиса, который придет из API
  /// [deviceName] - имя устройства для отображения
  Future<AdvertisingResult> startAdvertising({
    required final String serviceUuid,
    final String? deviceName,
  });

  /// Остановить advertising
  Future<AdvertisingResult> stopAdvertising();

  /// Проверить, активен ли advertising
  Future<bool> get isAdvertising;

  /// Сбросить состояние репозитория
  Future<void> reset();

  /// Включить/выключить логирование
  void setLoggingEnabled(final bool enabled);
}
