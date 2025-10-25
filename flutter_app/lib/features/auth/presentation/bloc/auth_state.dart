part of 'auth_bloc.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);
  final User user;
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated([this.errorMessage]);
  final String? errorMessage;
}
