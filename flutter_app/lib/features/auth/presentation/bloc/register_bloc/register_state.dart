part of 'register_bloc.dart';

sealed class RegisterState {
  const RegisterState({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String name;
  final String email;
  final String password;
  final String confirmPassword;
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial()
    : super(name: '', email: '', password: '', confirmPassword: '');
}

final class RegisterFormChanged extends RegisterState {
  const RegisterFormChanged({
    required super.name,
    required super.email,
    required super.password,
    required super.confirmPassword,
  });
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading({
    required super.name,
    required super.email,
    required super.password,
    required super.confirmPassword,
  });
}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess({
    required this.user,
    required super.name,
    required super.email,
    required super.password,
    required super.confirmPassword,
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
  });

  final String message;
}
