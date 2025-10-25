part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

final class Login extends AuthEvent {
  const Login({required this.email, required this.password});
  final String email;
  final String password;
}

final class Register extends AuthEvent {
  const Register({
    required this.email,
    required this.password,
    required this.name,
  });
  final String email;
  final String password;
  final String name;
}

final class Logout extends AuthEvent {
  const Logout();
}
