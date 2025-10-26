import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/repositories/session_repository.dart';

class LogoutUseCase {
  const LogoutUseCase(this._sessionRepository);

  final SessionRepository _sessionRepository;

  /// Throws [AuthException] при ошибке
  Future<void> call() => _sessionRepository.clearUserSession();
}
