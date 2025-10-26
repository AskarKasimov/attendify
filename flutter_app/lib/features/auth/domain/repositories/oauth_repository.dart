import 'package:attendify/features/auth/domain/entities/user.dart';

// больше не нужно
// ignore: one_member_abstracts
abstract class OAuthRepository {
  Future<User> authenticateWithAuthentic();
}
