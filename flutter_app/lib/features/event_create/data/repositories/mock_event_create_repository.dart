import 'package:attendify/features/event_create/data/repositories/event_create_repository.dart';
import 'package:attendify/features/event_create/domain/entities/event_create_response.dart';

class MockEventCreateRepository implements EventCreateRepository {
  @override
  Future<EventCreateResponse> createEvent(final String name) async {
    await Future.delayed(const Duration(seconds: 1));
    return EventCreateResponse(
      pin: '222222',
      eventName: name,
      eventId: 'mock_event_id',
    );
  }
}
