import 'dart:convert';
import 'package:attendify/features/auth/data/adapters/user_adapter.dart';
import 'package:attendify/features/auth/data/models/user_dto.dart';
import 'package:attendify/features/auth/domain/entities/auth_result.dart';
import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/repositories/secure_storage.dart';
import 'package:attendify/features/auth/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  const SessionRepositoryImpl({required final SecureStorage secureStorage})
    : _secureStorage = secureStorage;

  final SecureStorage _secureStorage;

  static const String _userSessionKey = 'user_session';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  @override
  Future<void> saveAuthSession(final AuthResult authResult) async {
    try {
      await _secureStorage.write(
        key: _accessTokenKey,
        value: authResult.accessToken,
      );

      if (authResult.refreshToken != null) {
        await _secureStorage.write(
          key: _refreshTokenKey,
          value: authResult.refreshToken!,
        );
      }

      final userDto = UserAdapter.fromDomain(authResult.user);
      final userJson = json.encode(userDto.toJson());
      await _secureStorage.write(key: _userSessionKey, value: userJson);
    } catch (e) {
      throw UnknownAuthException('Failed to save session: $e');
    }
  }

  @override
  Future<User?> getCurrentUserSession() async {
    try {
      final token = await _secureStorage.read(key: _accessTokenKey);
      final userJson = await _secureStorage.read(key: _userSessionKey);

      if (token == null || userJson == null) {
        return null;
      }

      final userMap = json.decode(userJson) as Map<String, dynamic>;
      final userDto = UserDto.fromJson(userMap);

      return UserAdapter.toDomain(userDto);
    } catch (e) {
      // если данные повреждены, сессию надо очистить
      await clearUserSession();
      return null;
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read(key: _accessTokenKey);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearUserSession() async {
    try {
      await _secureStorage.delete(key: _accessTokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
      await _secureStorage.delete(key: _userSessionKey);
    } catch (e) {
      throw UnknownAuthException('Session clear: $e');
    }
  }

  @override
  Future<bool> hasActiveSession() async {
    try {
      final token = await _secureStorage.read(key: _accessTokenKey);
      final userJson = await _secureStorage.read(key: _userSessionKey);
      return token != null && userJson != null;
    } catch (e) {
      return false;
    }
  }
}
