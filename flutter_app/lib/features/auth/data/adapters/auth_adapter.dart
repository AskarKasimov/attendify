import 'package:flutter_app/features/auth/data/models/auth_dto.dart';
import 'package:flutter_app/features/auth/domain/value_objects/auth_value_objects.dart';

class AuthAdapter {
  static LoginRequestDto createLoginRequest({
    required final Email email,
    required final Password password,
  }) => LoginRequestDto(
      email: email.value,
      password: password.value,
    );

  static RegisterRequestDto createRegisterRequest({
    required final Email email,
    required final Password password,
    required final UserName name,
  }) => RegisterRequestDto(
      email: email.value,
      password: password.value,
      name: name.value,
    );
}
