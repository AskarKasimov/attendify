import 'dart:async';

import 'package:attendify/features/event_join/domain/entities/event_join_response.dart';
import 'package:attendify/features/event_join/domain/entities/event_pin.dart';
import 'package:attendify/features/event_join/domain/repositories/event_join_repository.dart';

class MockEventJoinRepository implements EventJoinRepository {
  const MockEventJoinRepository();

  @override
  Future<EventJoinResponse> joinEventWithPin(EventPin pin) async {
    // Симулируем небольшую задержку сети
    await Future.delayed(const Duration(milliseconds: 700));

    if (pin.value == '222222') {
      return const EventJoinResponse(
        uuid: '123e4567-e89b-12d3-a456-426614174000',
        eventName: 'Mock Event',
        description: 'Тестовое событие (mock)',
      );
    }

    throw Exception('Invalid PIN');
  }
}
