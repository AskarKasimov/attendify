import 'package:attendify/features/event_join/domain/entities/event_pin.dart';
import 'package:attendify/features/event_join/domain/usecases/join_event_use_case.dart';
import 'package:attendify/features/event_join/presentation/bloc/event_join_event.dart';
import 'package:attendify/features/event_join/presentation/bloc/event_join_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventJoinBloc extends Bloc<EventJoinEvent, EventJoinState> {
  EventJoinBloc({required this.joinEventUseCase})
    : super(const EventJoinInitialState()) {
    on<PinChangedEvent>(_onPinChanged);
    on<JoinRequestedEvent>(_onJoinRequested);
    on<ResetStateEvent>(_onResetState);
  }

  final JoinEventUseCase joinEventUseCase;

  void _onPinChanged(
    final PinChangedEvent event,
    final Emitter<EventJoinState> emit,
  ) {
    emit(EventJoinPinChangedState(pin: event.pin));
  }

  Future<void> _onJoinRequested(
    final JoinRequestedEvent event,
    final Emitter<EventJoinState> emit,
  ) async {
    final currentPin = state.pin;

    if (currentPin.length != 6) {
      emit(
        EventJoinErrorState(
          pin: currentPin,
          message: 'PIN код должен содержать 6 цифр',
        ),
      );
      return;
    }

    emit(EventJoinLoadingState(pin: currentPin));

    try {
      final pin = EventPin(value: currentPin);
      final response = await joinEventUseCase(pin);

      emit(EventJoinSuccessState(pin: currentPin, response: response));
    } catch (e) {
      emit(EventJoinErrorState(pin: currentPin, message: e.toString()));
    }
  }

  void _onResetState(
    final ResetStateEvent event,
    final Emitter<EventJoinState> emit,
  ) {
    emit(const EventJoinInitialState());
  }
}
