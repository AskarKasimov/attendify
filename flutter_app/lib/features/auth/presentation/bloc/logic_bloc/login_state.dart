part of 'login_bloc.dart';

sealed class LoginState {
  const LoginState({
    required this.email,
    required this.password,
    this.showValidationErrors = false,
  });

  final String email;
  final String password;
  final bool showValidationErrors;
}

final class LoginInitial extends LoginState {
  const LoginInitial()
    : super(email: '', password: '', showValidationErrors: false);
}

final class LoginFormChanged extends LoginState {
  const LoginFormChanged({
    required super.email,
    required super.password,
    super.showValidationErrors = false,
  });
}

final class LoginLoading extends LoginState {
  const LoginLoading({
    required super.email,
    required super.password,
    super.showValidationErrors = false,
  });
}

final class LoginSuccess extends LoginState {
  const LoginSuccess({
    required this.user,
    required super.email,
    required super.password,
    super.showValidationErrors = false,
  });

  final User user;
}

final class LoginFailure extends LoginState {
  const LoginFailure({
    required this.message,
    required super.email,
    required super.password,
    super.showValidationErrors = false,
  });

  final String message;
}
