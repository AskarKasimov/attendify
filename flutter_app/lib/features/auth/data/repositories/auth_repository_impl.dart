import 'package:attendify/features/auth/data/adapters/user_adapter.dart';
import 'package:attendify/features/auth/data/models/user_dto.dart';
import 'package:attendify/features/auth/domain/entities/auth_result.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendify/features/auth/domain/value_objects/auth_value_objects.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl();

  // Мокированные данные пользователей
  static final Map<String, Map<String, dynamic>> _mockUsers = {
    'test@test.com': {
      'id': '1',
      'email': 'test@test.com',
      'name': 'Test User',
      'password': '123456',
      'avatarUrl': null,
    },
    'admin@admin.com': {
      'id': '2',
      'email': 'admin@admin.com',
      'name': 'Admin User',
      'password': 'admin123',
      'avatarUrl': null,
    },
  };

  @override
  Future<AuthResult> login({
    required final Email email,
    required final Password password,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final userData = _mockUsers[email.value];

      if (userData == null) {
        throw const UserNotFoundException();
      }

      if (userData['password'] != password.value) {
        throw const InvalidCredentialsException();
      }

      // Создаем DTO из мокированных данных
      final userDto = UserDto(
        id: userData['id'] as String,
        email: userData['email'] as String,
        name: userData['name'] as String,
        avatar_url: userData['avatarUrl'] as String?,
      );

      // Конвертируем DTO в доменную сущность через адаптер
      final user = UserAdapter.toDomain(userDto);

      return AuthResult(
        user: user,
        accessToken:
            'mock_access_token_${user.id}_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken:
            'mock_refresh_token_${user.id}_${DateTime.now().millisecondsSinceEpoch}',
      );
    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }
      throw UnknownAuthException(e.toString());
    }
  }

  @override
  Future<AuthResult> register({
    required final Email email,
    required final Password password,
    required final UserName name,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      if (_mockUsers.containsKey(email.value)) {
        throw const EmailAlreadyExistsException();
      }

      if (password.value.length < 6) {
        throw const WeakPasswordException();
      }

      final userId = DateTime.now().millisecondsSinceEpoch.toString();

      // Создаем DTO для нового пользователя
      final userDto = UserDto(
        id: userId,
        email: email.value,
        name: name.value,
        avatar_url: null,
      );

      // Конвертируем в доменную сущность через адаптер
      final user = UserAdapter.toDomain(userDto);

      // Add to mock database
      _mockUsers[email.value] = {
        'id': userId,
        'email': email.value,
        'name': name.value,
        'password': password.value,
        'avatarUrl': null,
      };

      return AuthResult(
        user: user,
        accessToken:
            'mock_access_token_${user.id}_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken:
            'mock_refresh_token_${user.id}_${DateTime.now().millisecondsSinceEpoch}',
      );
    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }
      throw UnknownAuthException(e.toString());
    }
  }
}
