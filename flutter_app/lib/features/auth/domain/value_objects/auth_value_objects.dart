import 'package:attendify/shared/errors/validation_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_value_objects.freezed.dart';

@freezed
class Email with _$Email {
  const factory Email({required final String value}) = _Email;
  const Email._();

  factory Email.create(final String email) {
    final error = validate(email);
    if (error != null) {
      throw ValidationException(error);
    }
    return Email(value: email.trim().toLowerCase());
  }

  static String? validate(final String email) {
    if (email.trim().isEmpty) {
      return 'Электронная почта не может быть пустой';
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.trim())) {
      return 'Неверный формат электронной почты';
    }

    return null;
  }

  @override
  String toString() => value;
}

@freezed
class Password with _$Password {
  const factory Password({required final String value}) = _Password;
  const Password._();

  factory Password.create(final String password) {
    final error = validate(password);
    if (error != null) {
      throw ValidationException(error);
    }
    return Password(value: password);
  }

  static String? validate(final String password) {
    if (password.isEmpty) {
      return 'Пароль не может быть пустым';
    }

    if (password.length < 8) {
      return 'Пароль должен содержать минимум 8 символов';
    }

    return null;
  }

  @override
  String toString() => '*' * value.length;
}

@freezed
class UserName with _$UserName {
  const factory UserName({required final String value}) = _UserName;
  const UserName._();

  factory UserName.create(final String name) {
    final error = validate(name);
    if (error != null) {
      throw ValidationException(error);
    }
    return UserName(value: name.trim());
  }

  static String? validate(final String name) {
    final trimmed = name.trim();

    if (trimmed.isEmpty) {
      return 'Имя не может быть пустым';
    }

    if (trimmed.length < 2) {
      return 'Имя должно содержать минимум 2 символа';
    }

    if (trimmed.length > 64) {
      return 'Имя не может быть длиннее 64 символов';
    }

    return null;
  }

  @override
  String toString() => value;
}

/// Валидация подтверждения пароля
class ConfirmPassword {
  static String? validate(final String password, final String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Подтверждение пароля не может быть пустым';
    }
    if (password != confirmPassword) {
      return 'Пароли не совпадают';
    }
    return null;
  }
}
