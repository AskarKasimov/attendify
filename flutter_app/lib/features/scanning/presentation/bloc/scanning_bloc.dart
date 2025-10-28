import 'dart:async';

import 'package:attendify/features/scanning/domain/usecases/scan_for_event_devices_usecase.dart';
import 'package:attendify/features/scanning/presentation/bloc/scanning_event.dart';
import 'package:attendify/features/scanning/presentation/bloc/scanning_state.dart';
import 'package:attendify/shared/constants/ble_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BLoC для управления сканированием BLE устройств
class ScanningBloc extends Bloc<ScanningEvent, ScanningState> {
  ScanningBloc(this._scanUseCase) : super(const ScanningInitialState()) {
    on<StartScanningEvent>(_onStartScanning);
    on<ClearResultsEvent>(_onClearResults);
  }

  final ScanForEventDevicesUseCase _scanUseCase;

  Future<void> _onStartScanning(
    final StartScanningEvent event,
    final Emitter<ScanningState> emit,
  ) async {
    try {
      emit(const ScanningScanningState());

      // Сканирование теперь синхронное, старое можно не останавливать

      // Запускаем новое сканирование с хардкод UUID
      final devices = await _scanUseCase(
        serviceUuidFromApi: BleConstants.eventServiceUuid,
        timeout: BleConstants.defaultScanTimeout,
      );

      if (!emit.isDone) {
        emit(ScanningSuccessState(devices));
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(ScanningErrorState('Failed to start scanning: $e'));
      }
    }
  }

  void _onClearResults(
    final ClearResultsEvent event,
    final Emitter<ScanningState> emit,
  ) {
    if (!emit.isDone) {
      emit(const ScanningInitialState());
    }
  }
}
