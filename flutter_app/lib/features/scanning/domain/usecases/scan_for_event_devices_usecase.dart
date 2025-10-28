import 'package:attendify/features/scanning/domain/entities/ble_device.dart';
import 'package:attendify/features/scanning/domain/repositories/ble_repository.dart';

/// Use case для сканирования BLE устройств с UUID из API
class ScanForEventDevicesUseCase {
  const ScanForEventDevicesUseCase(this._repository);

  final BleRepository _repository;

  /// Запустить сканирование устройств события
  ///
  /// [serviceUuidFromApi] - UUID сервиса, полученный из API
  /// [timeout] - максимальное время сканирования
  ///
  /// Возвращает список найденных устройств
  Future<List<BleDevice>> call({
    required final String serviceUuidFromApi,
    final Duration timeout = const Duration(seconds: 10),
  }) => _repository.scanForDevices(
    serviceUuid: serviceUuidFromApi,
    timeout: timeout,
  );
}
