part of 'login_bloc.dart';

sealed class LoginState {
  const LoginState({
    required this.email,
    required this.password,
  });
  
  final String email;
  final String password;
}

final class LoginInitial extends LoginState {
  const LoginInitial() : super(email: '', password: '');
}

final class LoginFormChanged extends LoginState {
  const LoginFormChanged({
    required super.email,
    required super.password,
  });
}

final class LoginLoading extends LoginState {
  const LoginLoading({
    required super.email,
    required super.password,
  });
}

final class LoginSuccess extends LoginState {
  const LoginSuccess({
    required this.user,
    required super.email,
    required super.password,
  });

  final User user;
}

final class LoginFailure extends LoginState {
  const LoginFailure({
    required this.message,
    required super.email,
    required super.password,
  });

  final String message;
}
