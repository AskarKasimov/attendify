import 'package:attendify/features/event_join/data/adapters/event_join_adapter.dart';
import 'package:attendify/features/event_join/data/models/event_join_dto.dart';
import 'package:attendify/features/event_join/domain/entities/event_join_response.dart';
import 'package:attendify/features/event_join/domain/entities/event_pin.dart';
import 'package:attendify/features/event_join/domain/repositories/event_join_repository.dart';
import 'package:attendify/shared/network/http_client.dart';

class EventJoinRepositoryImpl implements EventJoinRepository {
  const EventJoinRepositoryImpl(this._httpClient);

  final HttpClient _httpClient;

  @override
  Future<EventJoinResponse> joinEventWithPin(final EventPin pin) async {
    try {
      final requestDto = EventJoinAdapter.toRequestDto(pin);

      final response = await _httpClient.post(
        '/events/join',
        data: requestDto.toJson(),
      );

      final responseDto = JoinEventResponseDto.fromJson(
        response.data as Map<String, dynamic>,
      );

      return EventJoinAdapter.toDomain(responseDto);
    } catch (e) {
      if (e is HttpException) {
        // Обработка HTTP ошибок
        switch (e.statusCode) {
          case 400:
            throw Exception('Некорректный PIN код');
          case 404:
            throw Exception('Событие с таким PIN не найдено');
          case 410:
            throw Exception('PIN код истёк');
          default:
            throw Exception('Ошибка сервера: ${e.message}');
        }
      }
      throw Exception('Не удалось присоединиться к событию: $e');
    }
  }
}
