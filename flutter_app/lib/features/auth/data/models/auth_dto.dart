// DTO
// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_dto.freezed.dart';
part 'auth_dto.g.dart';

@freezed
class LoginRequestDto with _$LoginRequestDto {
  const factory LoginRequestDto({
    required final String email,
    required final String password,
  }) = _LoginRequestDto;

  factory LoginRequestDto.fromJson(final Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);
}

@freezed
class RegisterRequestDto with _$RegisterRequestDto {
  const factory RegisterRequestDto({
    required final String email,
    required final String password,
    required final String name,
  }) = _RegisterRequestDto;

  factory RegisterRequestDto.fromJson(final Map<String, dynamic> json) =>
      _$RegisterRequestDtoFromJson(json);
}

@freezed
class AuthResponseDto with _$AuthResponseDto {
  const factory AuthResponseDto({
    required final String access_token,
    required final String refresh_token,
    required final Map<String, dynamic> user,
  }) = _AuthResponseDto;

  factory AuthResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);
}
