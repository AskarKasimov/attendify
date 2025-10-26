import 'dart:convert';

import 'package:attendify/features/auth/domain/entities/auth_result.dart';
import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/repositories/oauth_repository.dart';
import 'package:attendify/features/auth/domain/value_objects/auth_value_objects.dart';
import 'package:attendify/shared/config/env.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class OAuthRepositoryImpl implements OAuthRepository {
  const OAuthRepositoryImpl(this._appAuth);

  final FlutterAppAuth _appAuth;

  @override
  Future<AuthResult> authenticateWithAuthentic() async {
    try {
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          Env.clientId,
          Env.redirectUrl,
          issuer: Env.issuer,
          scopes: ['openid', 'profile', 'email'],
        ),
      );

      if (result.accessToken == null) {
        throw Exception('No access token received from OAuth provider');
      }

      final userInfo = _parseUserFromIdToken(result.idToken!);

      final user = User(
        id: userInfo['sub'] ?? '',
        email: Email(value: userInfo['email'] ?? ''),
        name: UserName(
          value: userInfo['name'] ?? userInfo['preferred_username'] ?? '',
        ),
      );

      return AuthResult(
        user: user,
        accessToken: result.accessToken!,
        refreshToken: result.refreshToken, // может быть null
      );
    } catch (e) {
      throw Exception('OAuth authentication failed: $e');
    }
  }

  Map<String, dynamic> _parseUserFromIdToken(final String idToken) {
    final parts = idToken.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT format');
    }

    // base64url payload
    var payload = parts[1];

    // padding
    switch (payload.length % 4) {
      case 2:
        payload += '==';
      case 3:
        payload += '=';
    }

    try {
      final decoded = base64Url.decode(payload);
      return json.decode(utf8.decode(decoded)) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Ошибка JWT: $e');
    }
  }
}
