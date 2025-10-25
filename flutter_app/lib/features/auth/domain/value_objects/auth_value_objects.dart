import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_value_objects.freezed.dart';

@freezed
class Email with _$Email {
  const factory Email({required final String value}) = _Email;

  factory Email.create(final String email) {
    if (email.trim().isEmpty) {
      throw ArgumentError('Электронная почта не может быть пустой');
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.trim())) {
      throw ArgumentError('Неверный формат электронной почты');
    }

    return Email(value: email.trim().toLowerCase());
  }

  const Email._();

  @override
  String toString() => value;
}

@freezed
class Password with _$Password {
  const factory Password({required final String value}) = _Password;

  factory Password.create(final String password) {
    if (password.isEmpty) {
      throw ArgumentError('Пароль не может быть пустым');
    }

    if (password.length < 8) {
      throw ArgumentError('Пароль должен содержать минимум 8 символов');
    }

    return Password(value: password);
  }

  const Password._();

  @override
  String toString() => '*' * value.length;
}

@freezed
class UserName with _$UserName {
  const factory UserName({required final String value}) = _UserName;

  factory UserName.create(final String name) {
    final trimmed = name.trim();

    if (trimmed.isEmpty) {
      throw ArgumentError('Имя не может быть пустым');
    }

    if (trimmed.length < 2) {
      throw ArgumentError('Имя должно содержать минимум 2 символа');
    }

    if (trimmed.length > 64) {
      throw ArgumentError('Имя не может быть длиннее 64 символов');
    }

    return UserName(value: trimmed);
  }

  const UserName._();

  @override
  String toString() => value;
}
