/// Константы для BLE взаимодействия
class BleConstants {
  /// Хардкод UUID для тестирования - все устройства используют этот UUID
  static const String eventServiceUuid = '12345678-1234-5678-9012-123456789ABC';

  /// Имя устройства по умолчанию для advertising
  static const String defaultDeviceName = 'Attendify User';

  /// Таймаут для операций сканирования
  static const Duration defaultScanTimeout = Duration(seconds: 15);

  /// Таймаут для операций advertising
  static const Duration defaultAdvertisingTimeout = Duration(seconds: 30);
}
