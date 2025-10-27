import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/repositories/oauth_repository.dart';
import 'package:attendify/features/auth/domain/repositories/session_repository.dart';

class AuthenticLoginUseCase {
  const AuthenticLoginUseCase(this._oauthRepository, this._sessionRepository);

  final OAuthRepository _oauthRepository;
  final SessionRepository _sessionRepository;

  Future<User> call() async {
    try {
      // получаем пользователя
      final authResult = await _oauthRepository.authenticateWithAuthentic();

      // сохранение сессии локально
      await _sessionRepository.saveAuthSession(authResult);

      return authResult.user;
    } catch (e) {
      throw Exception('OAuth failed: $e');
    }
  }
}
