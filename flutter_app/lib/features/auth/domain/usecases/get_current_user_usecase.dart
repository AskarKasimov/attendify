import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/repositories/session_repository.dart';

class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._sessionRepository);

  final SessionRepository _sessionRepository;

  /// Throws [AuthException] при ошибке
  Future<User?> call() => _sessionRepository.getCurrentUserSession();
}
