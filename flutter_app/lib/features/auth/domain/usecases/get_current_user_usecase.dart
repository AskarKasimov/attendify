import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  /// Получить текущего пользователя
  /// Throws [AuthException] при ошибке
  Future<User?> call() => _repository.getCurrentUser();
}
