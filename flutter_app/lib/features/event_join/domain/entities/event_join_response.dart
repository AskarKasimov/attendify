class EventJoinResponse {
  const EventJoinResponse({
    required this.uuid,
    required this.eventName,
    this.description,
  });

  final String uuid;
  final String eventName;
  final String? description;
}
