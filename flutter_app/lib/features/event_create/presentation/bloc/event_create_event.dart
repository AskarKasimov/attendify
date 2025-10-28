abstract class EventCreateEvent {}

class EventNameChangedEvent extends EventCreateEvent {
  EventNameChangedEvent(this.name);

  final String name;
}

class CreateRequestedEvent extends EventCreateEvent {}

class ResetStateEvent extends EventCreateEvent {}
