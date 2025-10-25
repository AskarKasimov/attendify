import 'package:flutter_app/core/errors/auth_exceptions.dart';

import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  const LogoutUseCase(this._repository);

  final AuthRepository _repository;

  /// Выполнить выход из системы
  /// Throws [AuthException] при ошибке
  Future<void> call() => _repository.logout();
}
