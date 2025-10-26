import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendify/features/auth/domain/repositories/session_repository.dart';
import 'package:attendify/features/auth/domain/value_objects/auth_value_objects.dart';
import 'package:attendify/shared/errors/validation_exception.dart';

class RegisterUseCase {
  const RegisterUseCase(this._authRepository, this._sessionRepository);

  final AuthRepository _authRepository;
  final SessionRepository _sessionRepository;

  /// Throws [AuthException] при ошибке валидации или регистрации
  Future<User> call({
    required final String email,
    required final String password,
    required final String name,
    required final String confirmPassword,
  }) async {
    // Валидация входных данных
    final emailVO = Email.create(email); // Может бросить ArgumentError
    final passwordVO = Password.create(password); // Может бросить ArgumentError
    final nameVO = UserName.create(name); // Может бросить ArgumentError

    // Валидация совпадения паролей
    final confirmPasswordError = ConfirmPassword.validate(
      password,
      confirmPassword,
    );
    if (confirmPasswordError != null) {
      throw ValidationException(confirmPasswordError);
    }

    final authResult = await _authRepository.register(
      email: emailVO,
      password: passwordVO,
      name: nameVO,
    );

    await _sessionRepository.saveAuthSession(authResult);

    return authResult.user;
  }
}
