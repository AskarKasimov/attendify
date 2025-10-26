part of 'register_bloc.dart';

sealed class RegisterEvent {
  const RegisterEvent();
}

final class RegisterNameChanged extends RegisterEvent {
  const RegisterNameChanged(this.name);
  final String name;
}

final class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);
  final String email;
}

final class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);
  final String password;
}

final class RegisterConfirmPasswordChanged extends RegisterEvent {
  const RegisterConfirmPasswordChanged(this.confirmPassword);
  final String confirmPassword;
}

final class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}

final class RegisterValidationRequested extends RegisterEvent {
  const RegisterValidationRequested();
}
