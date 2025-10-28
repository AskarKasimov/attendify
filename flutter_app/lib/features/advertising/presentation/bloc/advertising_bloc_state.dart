sealed class AdvertisingBlocState {
  const AdvertisingBlocState();
}

class AdvertisingInitialState extends AdvertisingBlocState {
  const AdvertisingInitialState();
}

class AdvertisingStartingState extends AdvertisingBlocState {
  const AdvertisingStartingState();
}

class AdvertisingActiveState extends AdvertisingBlocState {
  const AdvertisingActiveState(this.serviceUuid, this.deviceName);

  final String serviceUuid;
  final String deviceName;
}

class AdvertisingStoppingState extends AdvertisingBlocState {
  const AdvertisingStoppingState();
}

class AdvertisingErrorState extends AdvertisingBlocState {
  const AdvertisingErrorState(this.message);

  final String message;
}
