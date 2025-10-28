import 'package:attendify/features/event_join/domain/entities/event_join_response.dart';
import 'package:attendify/features/event_join/domain/entities/event_pin.dart';

abstract class EventJoinRepository {
  /// Отправляет PIN код и получает UUID для BLE рекламирования
  Future<EventJoinResponse> joinEventWithPin(EventPin pin);
}