import 'package:attendify/features/auth/domain/entities/auth_result.dart';
import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendify/features/auth/domain/value_objects/auth_value_objects.dart';

class MockAuthRepository implements AuthRepository {
  const MockAuthRepository();

  @override
  Future<AuthResult> login({
    required final Email email,
    required final Password password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (email.value == 'test@example.com' && password.value == 'password') {
      final user = User(
        id: '1',
        email: email,
        name: const UserName(value: 'Test User'),
        avatarUrl: null,
      );

      return AuthResult(
        user: user,
        accessToken: 'mock_access_token',
        refreshToken: 'mock_refresh_token',
      );
    }

    throw Exception('Invalid credentials');
  }

  @override
  Future<AuthResult> register({
    required final Email email,
    required final Password password,
    required final UserName name,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      avatarUrl: null,
    );

    return AuthResult(
      user: user,
      accessToken: 'mock_access_token',
      refreshToken: 'mock_refresh_token',
    );
  }
}
