import 'package:attendify/features/auth/domain/entities/auth_result.dart';
import 'package:attendify/features/auth/domain/value_objects/auth_value_objects.dart';

abstract class AuthRepository {
  Future<AuthResult> login({
    required final Email email,
    required final Password password,
  });

  Future<AuthResult> register({
    required final Email email,
    required final Password password,
    required final UserName name,
  });
}
