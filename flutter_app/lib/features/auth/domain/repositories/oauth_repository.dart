import 'package:attendify/features/auth/domain/entities/auth_result.dart';

// больше не нужно
// ignore: one_member_abstracts
abstract class OAuthRepository {
  Future<AuthResult> authenticateWithAuthentic();
}
