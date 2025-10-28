/// Состояния для BLoC advertising
sealed class AdvertisingBlocState {
  const AdvertisingBlocState();
}

/// Начальное состояние
class AdvertisingInitialState extends AdvertisingBlocState {
  const AdvertisingInitialState();
}

/// Запуск advertising
class AdvertisingStartingState extends AdvertisingBlocState {
  const AdvertisingStartingState();
}

/// Advertising активен
class AdvertisingActiveState extends AdvertisingBlocState {
  const AdvertisingActiveState(this.serviceUuid, this.deviceName);

  final String serviceUuid;
  final String deviceName;
}

/// Остановка advertising
class AdvertisingStoppingState extends AdvertisingBlocState {
  const AdvertisingStoppingState();
}

/// Ошибка advertising
class AdvertisingErrorState extends AdvertisingBlocState {
  const AdvertisingErrorState(this.message);

  final String message;
}
