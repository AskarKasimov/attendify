import 'package:attendify/features/event_join/domain/entities/event_join_response.dart';
import 'package:attendify/features/event_join/domain/entities/event_pin.dart';

// пока не надо больше
// ignore: one_member_abstracts
abstract class EventJoinRepository {
  Future<EventJoinResponse> joinEventWithPin(final EventPin pin);
}
