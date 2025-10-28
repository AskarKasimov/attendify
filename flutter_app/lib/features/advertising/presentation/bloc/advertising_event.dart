sealed class AdvertisingEvent {
  const AdvertisingEvent();
}

class StartAdvertisingEvent extends AdvertisingEvent {
  const StartAdvertisingEvent({required this.uuid, this.deviceName});

  final String uuid;
  final String? deviceName;
}

class StopAdvertisingEvent extends AdvertisingEvent {
  const StopAdvertisingEvent();
}

class ResetAdvertisingEvent extends AdvertisingEvent {
  const ResetAdvertisingEvent();
}
