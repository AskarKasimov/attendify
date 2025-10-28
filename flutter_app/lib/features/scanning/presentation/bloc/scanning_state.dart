import 'package:attendify/features/scanning/domain/entities/ble_device.dart';

/// Состояния для BLoC сканирования
sealed class ScanningState {
  const ScanningState({required this.eventId, required this.eventPin});
  final String eventId;
  final String eventPin;
}

/// Начальное состояние
class ScanningInitialState extends ScanningState {
  const ScanningInitialState({required super.eventId, required super.eventPin});
}

/// Сканирование в процессе
class ScanningScanningState extends ScanningState {
  const ScanningScanningState({
    required super.eventId,
    required super.eventPin,
  });
}

/// Устройства найдены
class ScanningSuccessState extends ScanningState {
  const ScanningSuccessState(
    this.devices, {
    required super.eventId,
    required super.eventPin,
  });
  final List<BleDevice> devices;
}

/// Ошибка сканирования
class ScanningErrorState extends ScanningState {
  const ScanningErrorState(
    this.message, {
    required super.eventId,
    required super.eventPin,
  });
  final String message;
}
