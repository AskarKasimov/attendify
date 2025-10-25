import 'package:flutter_app/core/errors/auth_exceptions.dart';

import 'package:flutter_app/features/auth/domain/entities/user.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  /// Получить текущего пользователя
  /// Throws [AuthException] при ошибке
  Future<User?> call() => _repository.getCurrentUser();
}
