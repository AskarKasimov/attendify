import 'package:flutter_app/features/auth/domain/value_objects/auth_value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required final String id,
    required final Email email,
    required final UserName name,
    final String? avatarUrl,
  }) = _User;

  const User._();

  String get displayName => name.value;

  String get emailAddress => email.value;

  bool get hasAvatar => avatarUrl != null && avatarUrl!.isNotEmpty;
}
