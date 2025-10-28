/// События для BLoC advertising
sealed class AdvertisingEvent {
  const AdvertisingEvent();
}

/// Начать advertising
class StartAdvertisingEvent extends AdvertisingEvent {
  const StartAdvertisingEvent({this.uuid, this.deviceName});
  
  final String? uuid;
  final String? deviceName;
}

/// Остановить advertising
class StopAdvertisingEvent extends AdvertisingEvent {
  const StopAdvertisingEvent();
}

/// Сбросить состояние
class ResetAdvertisingEvent extends AdvertisingEvent {
  const ResetAdvertisingEvent();
}
