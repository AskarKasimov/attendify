import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendify/features/auth/domain/value_objects/auth_value_objects.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  /// Выполнить вход в систему
  /// Throws [AuthException] при ошибке валидации или аутентификации
  Future<User> call({
    required final String email,
    required final String password,
  }) {
    // Валидация входных данных
    final emailVO = Email.create(email); // Может бросить ArgumentError
    final passwordVO = Password.create(password); // Может бросить ArgumentError

    // Вызов репозитория - может бросить AuthException
    return _repository.login(email: emailVO, password: passwordVO);
  }
}
