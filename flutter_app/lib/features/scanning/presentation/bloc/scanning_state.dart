import 'package:attendify/features/scanning/domain/entities/ble_device.dart';

/// Состояния для BLoC сканирования
sealed class ScanningState {
  const ScanningState();
}

/// Начальное состояние
class ScanningInitialState extends ScanningState {
  const ScanningInitialState();
}

/// Сканирование в процессе
class ScanningScanningState extends ScanningState {
  const ScanningScanningState();
}

/// Устройства найдены
class ScanningSuccessState extends ScanningState {
  const ScanningSuccessState(this.devices);

  final List<BleDevice> devices;
}

/// Ошибка сканирования
class ScanningErrorState extends ScanningState {
  const ScanningErrorState(this.message);

  final String message;
}
