import 'package:attendify/features/advertising/domain/entities/advertising_result.dart';
import 'package:attendify/features/advertising/domain/repositories/advertising_repository.dart';
import 'package:attendify/features/scanning/domain/entities/bluetooth_state.dart';

/// Use case для управления BLE advertising (маячком)
class ManageAdvertisingUseCase {
  const ManageAdvertisingUseCase(this._repository);

  final AdvertisingRepository _repository;

  /// Начать рекламирование устройства как маячка с UUID из API
  ///
  /// [serviceUuidFromApi] - UUID сервиса, полученный из API
  /// [deviceName] - имя устройства для отображения (опционально)
  Future<AdvertisingResult> startAdvertising({
    required final String serviceUuidFromApi,
    final String? deviceName,
  }) async {
    // Проверяем разрешения
    final hasPermissions = await _repository.checkAndRequestPermissions();
    if (!hasPermissions) {
      return const AdvertisingError('BLE permissions not granted');
    }

    // Проверяем состояние Bluetooth
    final bluetoothState = await _repository.bluetoothState;
    if (!bluetoothState.canAdvertise) {
      return AdvertisingError(
        'Bluetooth недоступен для advertising: $bluetoothState',
      );
    }

    // Запускаем advertising
    return _repository.startAdvertising(
      serviceUuid: serviceUuidFromApi,
      deviceName: deviceName,
    );
  }

  /// Остановить рекламирование устройства
  Future<AdvertisingResult> stopAdvertising() => _repository.stopAdvertising();

  /// Проверить, активен ли advertising
  Future<bool> get isAdvertising => _repository.isAdvertising;
}
