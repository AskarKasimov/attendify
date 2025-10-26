import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendify/features/auth/domain/repositories/session_repository.dart';
import 'package:attendify/features/auth/domain/value_objects/auth_value_objects.dart';

class LoginUseCase {
  const LoginUseCase(this._authRepository, this._sessionRepository);

  final AuthRepository _authRepository;
  final SessionRepository _sessionRepository;

  /// Throws [AuthException] при ошибке валидации или аутентификации
  Future<User> call({
    required final String email,
    required final String password,
  }) async {
    // Валидация входных данных
    final emailVO = Email.create(email); // Может бросить ArgumentError
    final passwordVO = Password.create(password); // Может бросить ArgumentError

    final authResult = await _authRepository.login(
      email: emailVO,
      password: passwordVO,
    );

    await _sessionRepository.saveAuthSession(authResult);

    return authResult.user;
  }
}
