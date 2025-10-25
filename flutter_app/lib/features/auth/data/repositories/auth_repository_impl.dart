import 'package:flutter_app/core/errors/auth_exceptions.dart';
import 'package:flutter_app/features/auth/data/adapters/user_adapter.dart';
import 'package:flutter_app/features/auth/data/models/user_dto.dart';
import 'package:flutter_app/features/auth/domain/entities/user.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_app/features/auth/domain/repositories/secure_storage.dart';
import 'package:flutter_app/features/auth/domain/value_objects/auth_value_objects.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required final SecureStorage secureStorage})
    : _secureStorage = secureStorage;

  final SecureStorage _secureStorage;

  static const String _tokenKey = 'access_token';

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
  Future<User> login({
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

      // Save only token
      await _secureStorage.write(
        key: _tokenKey,
        value: 'mock_token_${user.id}',
      );

      return user;
    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }
      throw UnknownAuthException(e.toString());
    }
  }

  @override
  Future<User> register({
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

      // Save only token
      await _secureStorage.write(key: _tokenKey, value: 'mock_token_$userId');

      return user;
    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }
      throw UnknownAuthException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _secureStorage.delete(key: _tokenKey);
    } catch (e) {
      throw UnknownAuthException(e.toString());
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final token = await _secureStorage.read(key: _tokenKey);

      if (token == null) {
        return null;
      }

      // Извлекаем ID пользователя из токена (в реальном приложении это делается через JWT)
      final userId = token.split('_').last;

      // Симулируем запрос к серверу для получения актуальных данных пользователя
      await Future.delayed(const Duration(milliseconds: 500));

      // Ищем пользователя по ID в "базе данных"
      final userData = _mockUsers.values.firstWhere(
        (final user) => user['id'] == userId,
        orElse: () => {},
      );

      if (userData.isEmpty) {
        // Токен недействителен - удаляем его
        await _secureStorage.delete(key: _tokenKey);
        return null;
      }

      final userDto = UserDto(
        id: userData['id'] as String,
        email: userData['email'] as String,
        name: userData['name'] as String,
        avatar_url: userData['avatarUrl'] as String?,
      );

      return UserAdapter.toDomain(userDto);
    } catch (e) {
      throw UnknownAuthException(e.toString());
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final token = await _secureStorage.read(key: _tokenKey);
      return token != null;
    } catch (e) {
      return false;
    }
  }
}
