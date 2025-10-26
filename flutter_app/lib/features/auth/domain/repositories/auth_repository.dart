import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/value_objects/auth_value_objects.dart';

abstract class AuthRepository {
  /// Вход в систему. Throws [AuthException] при ошибке
  Future<User> login({
    required final Email email,
    required final Password password,
  });

  /// Регистрация. Throws [AuthException] при ошибке
  Future<User> register({
    required final Email email,
    required final Password password,
    required final UserName name,
  });

  /// Выход из системы. Throws [AuthException] при ошибке
  Future<void> logout();

  /// Получить текущего пользователя. Throws [AuthException] при ошибке
  Future<User?> getCurrentUser();

  /// Проверить, авторизован ли пользователь
  Future<bool> isLoggedIn();
}
