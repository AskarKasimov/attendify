import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_result.freezed.dart';

@freezed
class AuthResult with _$AuthResult {
  const factory AuthResult({
    required final User user,
    required final String accessToken,
    final String? refreshToken,
  }) = _AuthResult;
}
