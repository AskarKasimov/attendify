import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/repositories/oauth_repository.dart';

class AuthenticLoginUseCase {
  const AuthenticLoginUseCase(this._oauthRepository);

  final OAuthRepository _oauthRepository;

  Future<User> call() async {
    try {
      return await _oauthRepository.authenticateWithAuthentic();
    } catch (e) {
      throw Exception('OAuth failed: $e');
    }
  }
}
