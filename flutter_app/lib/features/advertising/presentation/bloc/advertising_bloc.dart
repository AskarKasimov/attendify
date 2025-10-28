import 'package:attendify/features/advertising/domain/entities/advertising_result.dart';
import 'package:attendify/features/advertising/domain/usecases/manage_advertising_usecase.dart';
import 'package:attendify/features/advertising/presentation/bloc/advertising_bloc_state.dart';
import 'package:attendify/features/advertising/presentation/bloc/advertising_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvertisingBloc extends Bloc<AdvertisingEvent, AdvertisingBlocState> {
  AdvertisingBloc(this._advertisingUseCase)
    : super(const AdvertisingInitialState()) {
    on<StartAdvertisingEvent>(_onStartAdvertising);
    on<StopAdvertisingEvent>(_onStopAdvertising);
    on<ResetAdvertisingEvent>(_onResetAdvertising);
  }

  final ManageAdvertisingUseCase _advertisingUseCase;

  Future<void> _onStartAdvertising(
    final StartAdvertisingEvent event,
    final Emitter<AdvertisingBlocState> emit,
  ) async {
    try {
      emit(const AdvertisingStartingState());
      final result = await _advertisingUseCase.startAdvertising(
        serviceUuidFromApi: event.uuid,
        deviceName: event.deviceName,
      );

      if (!emit.isDone) {
        switch (result) {
          case AdvertisingStarted(
            serviceUuid: final uuid,
            deviceName: final name,
          ):
            emit(AdvertisingActiveState(uuid, name));

          case AdvertisingError(message: final message):
            emit(AdvertisingErrorState(message));

          case AdvertisingStopped():
            emit(const AdvertisingInitialState());
        }
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(AdvertisingErrorState('Failed to start advertising: $e'));
      }
    }
  }

  Future<void> _onStopAdvertising(
    final StopAdvertisingEvent event,
    final Emitter<AdvertisingBlocState> emit,
  ) async {
    try {
      emit(const AdvertisingStoppingState());

      final result = await _advertisingUseCase.stopAdvertising();

      if (!emit.isDone) {
        switch (result) {
          case AdvertisingStopped():
            emit(const AdvertisingInitialState());

          case AdvertisingError(message: final message):
            emit(AdvertisingErrorState(message));

          case AdvertisingStarted():
            // Shouldn't happen but handle it
            emit(
              const AdvertisingErrorState('Unexpected state after stopping'),
            );
        }
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(AdvertisingErrorState('Failed to stop advertising: $e'));
      }
    }
  }

  void _onResetAdvertising(
    final ResetAdvertisingEvent event,
    final Emitter<AdvertisingBlocState> emit,
  ) {
    if (!emit.isDone) {
      emit(const AdvertisingInitialState());
    }
  }
}
