import 'package:freezed_annotation/freezed_annotation.dart';

part 'ble_device.freezed.dart';

/// Найденное BLE устройство
@freezed
class BleDevice with _$BleDevice {
  const factory BleDevice({
    /// Уникальный идентификатор устройства
    required final String id,

    /// Название устройства (может быть пустым)
    required final String name,

    /// Сила сигнала (Received Signal Strength Indicator)
    required final int rssi,

    /// Список UUID сервисов, которые рекламирует устройство
    required final List<String> serviceUuids,

    /// Дополнительные данные рекламы
    required final Map<String, dynamic> advertisementData,
  }) = _BleDevice;
  const BleDevice._();

  /// Расстояние до устройства на основе RSSI (примерно)
  double get estimatedDistance {
    if (rssi == 0) {
      return -1;
    }

    final ratio = rssi * 1.0 / -59; // -59 dBm на расстоянии 1 метр
    if (ratio < 1.0) {
      return ratio;
    } else {
      final accuracy =
          0.89976 * (ratio * ratio * ratio) +
          7.7095 * (ratio * ratio) +
          0.111 * ratio;
      return accuracy;
    }
  }

  /// Качество сигнала
  SignalQuality get signalQuality {
    if (rssi >= -50) {
      return SignalQuality.excellent;
    }
    if (rssi >= -60) {
      return SignalQuality.good;
    }
    if (rssi >= -70) {
      return SignalQuality.fair;
    }
    return SignalQuality.poor;
  }
}

/// Качество сигнала BLE устройства
enum SignalQuality {
  /// Отличное качество сигнала (> -50 dBm)
  excellent,

  /// Хорошее качество сигнала (-50 to -60 dBm)
  good,

  /// Удовлетворительное качество (-60 to -70 dBm)
  fair,

  /// Плохое качество (< -70 dBm)
  poor,
}
