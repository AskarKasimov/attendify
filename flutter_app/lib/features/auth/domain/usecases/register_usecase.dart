import 'package:flutter_app/core/errors/auth_exceptions.dart';
import 'package:flutter_app/features/auth/domain/entities/user.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_app/features/auth/domain/value_objects/auth_value_objects.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  /// Выполнить регистрацию пользователя
  /// Throws [AuthException] при ошибке валидации или регистрации
  Future<User> call({
    required final String email,
    required final String password,
    required final String name,
  }) {
    // Валидация входных данных
    final emailVO = Email.create(email); // Может бросить ArgumentError
    final passwordVO = Password.create(password); // Может бросить ArgumentError
    final nameVO = UserName.create(name); // Может бросить ArgumentError

    // Вызов репозитория - может бросить AuthException
    return _repository.register(
      email: emailVO,
      password: passwordVO,
      name: nameVO,
    );
  }
}
