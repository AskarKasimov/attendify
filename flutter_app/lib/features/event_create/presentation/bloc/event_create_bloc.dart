import 'package:attendify/features/event_create/data/repositories/event_create_repository.dart';
import 'package:attendify/features/event_create/presentation/bloc/event_create_event.dart';
import 'package:attendify/features/event_create/presentation/bloc/event_create_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventCreateBloc extends Bloc<EventCreateEvent, EventCreateState> {
  EventCreateBloc(this.repository) : super(EventCreateInitialState()) {
    on<EventNameChangedEvent>((final event, final emit) {
      _name = event.name;
      emit(EventCreateNameChangedState(_name));
    });
    on<CreateRequestedEvent>((final event, final emit) async {
      if (_name.isEmpty) {
        emit(const EventCreateErrorState('Название не может быть пустым'));
        return;
      }
      emit(EventCreateLoadingState());
      try {
        final response = await repository.createEvent(_name);
        emit(EventCreateSuccessState(response));
      } catch (e) {
        emit(EventCreateErrorState(e.toString()));
      }
    });
    on<ResetStateEvent>((final event, final emit) {
      emit(EventCreateInitialState());
    });
  }
  final EventCreateRepository repository;
  String _name = '';
}
