/// Результат операций advertising
sealed class AdvertisingResult {
  const AdvertisingResult();
}

/// Advertising успешно запущен
class AdvertisingStarted extends AdvertisingResult {
  const AdvertisingStarted(this.serviceUuid, this.deviceName);

  final String serviceUuid;
  final String deviceName;
}

/// Advertising успешно остановлен
class AdvertisingStopped extends AdvertisingResult {
  const AdvertisingStopped();
}

/// Ошибка advertising
class AdvertisingError extends AdvertisingResult {
  const AdvertisingError(this.message, [this.exception]);

  final String message;
  final Exception? exception;
}
