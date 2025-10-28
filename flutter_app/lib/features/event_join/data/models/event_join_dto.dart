class JoinEventRequestDto {
  const JoinEventRequestDto({required this.pin});

  final String pin;

  Map<String, dynamic> toJson() => {'pin': pin};

  factory JoinEventRequestDto.fromJson(Map<String, dynamic> json) =>
      JoinEventRequestDto(pin: json['pin'] as String);
}

/// DTO для ответа с данными события
class JoinEventResponseDto {
  const JoinEventResponseDto({
    required this.uuid,
    required this.eventName,
    this.description,
  });

  final String uuid;
  final String eventName;
  final String? description;

  factory JoinEventResponseDto.fromJson(Map<String, dynamic> json) =>
      JoinEventResponseDto(
        uuid: json['uuid'] as String,
        eventName: json['event_name'] as String,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'event_name': eventName,
    if (description != null) 'description': description,
  };
}
