import 'package:attendify/features/event_create/data/models/event_create_dto.dart';
import 'package:attendify/features/event_create/domain/entities/event_create_response.dart';
import 'package:dio/dio.dart';

import 'package:attendify/features/event_create/data/repositories/event_create_repository.dart';

class EventCreateRepositoryImpl implements EventCreateRepository {
  EventCreateRepositoryImpl(this.dio);
  final Dio dio;

  @override
  Future<EventCreateResponse> createEvent(final String name) async {
    final dto = EventCreateDto(name: name);
    final response = await dio.post('/event/create', data: dto.toJson());
    final data = response.data;
    return EventCreateResponse(
      pin: data['pin'] as String,
      eventName: data['event_name'] as String? ?? name,
      eventId: data['event_id'] as String? ?? '',
    );
  }
}
