import 'package:attendify/features/event_create/domain/entities/event_create_response.dart';

abstract class EventCreateState {
  const EventCreateState();
}

class EventCreateInitialState extends EventCreateState {}

class EventCreateNameChangedState extends EventCreateState {
  const EventCreateNameChangedState(this.name);
  final String name;
}

class EventCreateLoadingState extends EventCreateState {}

class EventCreateSuccessState extends EventCreateState {
  const EventCreateSuccessState(this.response);
  final EventCreateResponse response;
}

class EventCreateErrorState extends EventCreateState {
  const EventCreateErrorState(this.message);
  final String message;
}
