import 'package:attendify/features/event_join/domain/entities/event_join_response.dart';
import 'package:attendify/features/event_join/domain/entities/event_pin.dart';
import 'package:attendify/features/event_join/domain/repositories/event_join_repository.dart';

class JoinEventUseCase {
  const JoinEventUseCase(this._eventJoinRepository);

  final EventJoinRepository _eventJoinRepository;

  /// Присоединяется к событию по PIN коду
  /// Throws [Exception] при ошибке
  Future<EventJoinResponse> call(final EventPin pin) {
    if (!pin.isValid) {
      throw Exception('Некорректный PIN код');
    }

    return _eventJoinRepository.joinEventWithPin(pin);
  }
}
