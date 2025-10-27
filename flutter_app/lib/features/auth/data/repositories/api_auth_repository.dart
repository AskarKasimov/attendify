import 'package:attendify/features/auth/data/adapters/user_adapter.dart';
import 'package:attendify/features/auth/data/models/user_dto.dart';
import 'package:attendify/features/auth/domain/entities/auth_result.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendify/features/auth/domain/value_objects/auth_value_objects.dart';
import 'package:attendify/shared/network/http_client.dart';

class ApiAuthRepository implements AuthRepository {
  const ApiAuthRepository(this._httpClient);

  final HttpClient _httpClient;

  @override
  Future<AuthResult> login({
    required final Email email,
    required final Password password,
  }) async {
    try {
      final response = await _httpClient.post(
        '/auth/login',
        data: {'email': email.value, 'password': password.value},
      );

      final data = response.data as Map<String, dynamic>;
      final userDto = UserDto.fromJson(data['user'] as Map<String, dynamic>);
      final user = UserAdapter.toDomain(userDto);

      return AuthResult(
        user: user,
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String?,
      );
    } catch (e) {
      throw UnknownAuthException('Login failed: $e');
    }
  }

  @override
  Future<AuthResult> register({
    required final Email email,
    required final Password password,
    required final UserName name,
  }) async {
    try {
      final response = await _httpClient.post(
        '/auth/register',
        data: {
          'email': email.value,
          'password': password.value,
          'name': name.value,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final userDto = UserDto.fromJson(data['user'] as Map<String, dynamic>);
      final user = UserAdapter.toDomain(userDto);

      return AuthResult(
        user: user,
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String?,
      );
    } catch (e) {
      throw UnknownAuthException('Registration failed: $e');
    }
  }
}
