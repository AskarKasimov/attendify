/// Состояние BLE advertising (рекламирования)
enum AdvertisingState {
  /// Advertising остановлен
  idle,

  /// Запускается advertising
  starting,

  /// Advertising активен
  active,

  /// Останавливается advertising
  stopping,

  /// Ошибка advertising
  error,
}

/// Расширение для удобной работы с состояниями advertising
extension AdvertisingStateExtension on AdvertisingState {
  /// Можно ли запустить advertising
  bool get canStart => this == AdvertisingState.idle;

  /// Можно ли остановить advertising
  bool get canStop => this == AdvertisingState.active;

  /// Активен ли advertising
  bool get isActive => this == AdvertisingState.active;

  /// Есть ли ошибка
  bool get hasError => this == AdvertisingState.error;
}
