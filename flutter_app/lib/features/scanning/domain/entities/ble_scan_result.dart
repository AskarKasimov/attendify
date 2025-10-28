import 'package:attendify/features/scanning/domain/entities/ble_device.dart';

/// Результат операции BLE сканирования
sealed class BleScanResult {
  const BleScanResult();
}

/// Успешное обнаружение устройств
class BleScanSuccess extends BleScanResult {
  const BleScanSuccess(this.devices);

  /// Список найденных устройств
  final List<BleDevice> devices;

  /// Есть ли устройства с нужным сервисом
  bool get hasTargetDevices => devices.isNotEmpty;

  /// Устройство с самым сильным сигналом
  BleDevice? get strongestDevice {
    if (devices.isEmpty) {
      return null;
    }

    return devices.reduce((final a, final b) => a.rssi > b.rssi ? a : b);
  }
}

/// Ошибка при сканировании
class BleScanError extends BleScanResult {
  const BleScanError(this.message, [this.exception]);

  /// Сообщение об ошибке
  final String message;

  /// Исключение (если есть)
  final Exception? exception;
}

/// Состояние "сканирование в процессе"
class BleScanInProgress extends BleScanResult {
  const BleScanInProgress();
}

/// Состояние "сканирование не запущено"
class BleScanIdle extends BleScanResult {
  const BleScanIdle();
}
