/// Состояние Bluetooth адаптера
enum BluetoothState {
  /// Неизвестное состояние
  unknown,

  /// Bluetooth выключен
  off,

  /// Bluetooth включен и готов к работе
  on,

  /// Bluetooth включается
  turningOn,

  /// Bluetooth выключается
  turningOff,

  /// Bluetooth недоступен на устройстве
  unavailable,
}

/// Расширение для преобразования внешних состояний
extension BluetoothStateExtension on BluetoothState {
  /// Готов ли Bluetooth к работе
  bool get isReady => this == BluetoothState.on;

  /// Можно ли сканировать устройства
  bool get canScan => this == BluetoothState.on;

  /// Можно ли рекламировать
  bool get canAdvertise => this == BluetoothState.on;
}
