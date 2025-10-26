import 'package:attendify/features/auth/domain/entities/auth_result.dart';
import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';

abstract class SessionRepository {
  /// Throws [AuthException] при ошибке
  Future<void> saveAuthSession(final AuthResult authResult);

  /// Throws [AuthException] при ошибке
  Future<User?> getCurrentUserSession();

  Future<String?> getAccessToken();

  /// Throws [AuthException] при ошибке
  Future<void> clearUserSession();

  Future<bool> hasActiveSession();
}
