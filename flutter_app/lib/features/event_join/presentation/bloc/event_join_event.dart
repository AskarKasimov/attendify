sealed class EventJoinEvent {
  const EventJoinEvent();
}

class PinChangedEvent extends EventJoinEvent {
  const PinChangedEvent(this.pin);
  final String pin;
}

class JoinRequestedEvent extends EventJoinEvent {
  const JoinRequestedEvent();
}

class ResetStateEvent extends EventJoinEvent {
  const ResetStateEvent();
}
