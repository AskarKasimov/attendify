/// События для BLoC advertising
sealed class AdvertisingEvent {
  const AdvertisingEvent();
}

/// Начать advertising
class StartAdvertisingEvent extends AdvertisingEvent {
  const StartAdvertisingEvent();
}

/// Остановить advertising
class StopAdvertisingEvent extends AdvertisingEvent {
  const StopAdvertisingEvent();
}

/// Сбросить состояние
class ResetAdvertisingEvent extends AdvertisingEvent {
  const ResetAdvertisingEvent();
}
