import 'package:attendify/features/event_join/data/models/event_join_dto.dart';
import 'package:attendify/features/event_join/domain/entities/event_join_response.dart';
import 'package:attendify/features/event_join/domain/entities/event_pin.dart';

class EventJoinAdapter {
  static JoinEventRequestDto toRequestDto(final EventPin pin) =>
      JoinEventRequestDto(pin: pin.value);

  static EventJoinResponse toDomain(final JoinEventResponseDto dto) =>
      EventJoinResponse(
        uuid: dto.uuid,
        eventName: dto.eventName,
        description: dto.description,
      );
}
