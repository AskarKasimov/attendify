part of 'register_bloc.dart';

sealed class RegisterState {
  const RegisterState({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.showValidationErrors = false,
  });

  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool showValidationErrors;
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial()
    : super(
        name: '',
        email: '',
        password: '',
        confirmPassword: '',
        showValidationErrors: false,
      );
}

final class RegisterFormChanged extends RegisterState {
  const RegisterFormChanged({
    required super.name,
    required super.email,
    required super.password,
    required super.confirmPassword,
    super.showValidationErrors = false,
  });
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading({
    required super.name,
    required super.email,
    required super.password,
    required super.confirmPassword,
    super.showValidationErrors = false,
  });
}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess({
    required this.user,
    required super.name,
    required super.email,
    required super.password,
    required super.confirmPassword,
    super.showValidationErrors = false,
  });

  final User user;
}

final class RegisterFailure extends RegisterState {
  const RegisterFailure({
    required this.message,
    required super.name,
    required super.email,
    required super.password,
    required super.confirmPassword,
    super.showValidationErrors = false,
  });

  final String message;
}
