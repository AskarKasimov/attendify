import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendify/features/auth/domain/value_objects/auth_value_objects.dart';
import 'package:attendify/shared/errors/validation_exception.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  /// Выполнить регистрацию пользователя
  /// Throws [AuthException] при ошибке валидации или регистрации
  Future<User> call({
    required final String email,
    required final String password,
    required final String name,
    required final String confirmPassword,
  }) {
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

    // Вызов репозитория - может бросить AuthException
    return _repository.register(
      email: emailVO,
      password: passwordVO,
      name: nameVO,
    );
  }
}
