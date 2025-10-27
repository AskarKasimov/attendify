part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

final class AuthenticateUser extends AuthEvent {
  const AuthenticateUser(this.user);
  final User user;
}

final class Logout extends AuthEvent {
  const Logout();
}

final class AuthenticOAuthLogin extends AuthEvent {
  const AuthenticOAuthLogin();
}

final class SessionExpired extends AuthEvent {
  const SessionExpired();
}
