import 'package:attendify/features/event_create/domain/entities/event_create_response.dart';

abstract class EventCreateRepository {
  Future<EventCreateResponse> createEvent(final String name);
}
