import 'dart:async';

import 'package:attendify/features/scanning/domain/usecases/scan_for_event_devices_usecase.dart';
import 'package:attendify/features/scanning/presentation/bloc/scanning_event.dart';
import 'package:attendify/features/scanning/presentation/bloc/scanning_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanningBloc extends Bloc<ScanningEvent, ScanningState> {
  ScanningBloc(this._scanUseCase)
    : super(const ScanningInitialState(eventId: '', eventPin: '')) {
    on<StartScanningEvent>(_onStartScanning);
    on<ClearResultsEvent>(_onClearResults);
  }

  final ScanForEventDevicesUseCase _scanUseCase;

  Future<void> _onStartScanning(
    final StartScanningEvent event,
    final Emitter<ScanningState> emit,
  ) async {
    // Проверка обязательных параметров
    if (event.eventId.isEmpty || event.eventPin.isEmpty) {
      throw ArgumentError(
        'eventId и eventPin должны быть переданы и не быть пустыми',
      );
    }

    try {
      emit(
        ScanningScanningState(eventId: event.eventId, eventPin: event.eventPin),
      );

      final devices = await _scanUseCase(
        timeout: event.timeout ?? const Duration(seconds: 10),
      );

      if (!emit.isDone) {
        emit(
          ScanningSuccessState(
            devices,
            eventId: event.eventId,
            eventPin: event.eventPin,
          ),
        );
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(
          ScanningErrorState(
            'Failed to start scanning: $e',
            eventId: event.eventId,
            eventPin: event.eventPin,
          ),
        );
      }
    }
  }

  void _onClearResults(
    final ClearResultsEvent event,
    final Emitter<ScanningState> emit,
  ) {
    if (!emit.isDone) {
      // Для очистки используем последние eventId и eventPin из текущего state
      emit(
        ScanningInitialState(eventId: state.eventId, eventPin: state.eventPin),
      );
    }
  }
}
