import 'package:flutter_app/features/auth/data/models/user_dto.dart';
import 'package:flutter_app/features/auth/domain/entities/user.dart';
import 'package:flutter_app/features/auth/domain/value_objects/auth_value_objects.dart';

class UserAdapter {
  static User toDomain(final UserDto dto) => User(
    id: dto.id,
    email: Email.create(dto.email),
    name: UserName.create(dto.name),
    avatarUrl: dto.avatar_url,
  );

  static UserDto fromDomain(final User user) => UserDto(
    id: user.id,
    email: user.emailAddress,
    name: user.displayName,
    avatar_url: user.avatarUrl,
  );
}
