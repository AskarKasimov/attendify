// DTO
// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required final String id,
    required final String email,
    required final String name,
    final String? avatar_url,
    final DateTime? created_at,
    final DateTime? updated_at,
  }) = _UserDto;

  factory UserDto.fromJson(final Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
