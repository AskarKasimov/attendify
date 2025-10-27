import 'dart:async';

/// для уведомления о событиях аутентификации
class AuthEventService {
  factory AuthEventService() => _instance;

  AuthEventService._internal();
  static final AuthEventService _instance = AuthEventService._internal();

  final StreamController<AuthEventType> _controller =
      StreamController<AuthEventType>.broadcast();

  /// поток событий аутентификации
  Stream<AuthEventType> get events => _controller.stream;

  /// сброс
  void notifySessionExpired() {
    _controller.add(AuthEventType.sessionExpired);
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}

enum AuthEventType { sessionExpired }
