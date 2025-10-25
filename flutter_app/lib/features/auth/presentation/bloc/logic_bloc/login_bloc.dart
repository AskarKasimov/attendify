import 'package:attendify/core/errors/auth_exceptions.dart';
import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required final LoginUseCase loginUseCase})
    : _loginUseCase = loginUseCase,
      super(const LoginInitial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final LoginUseCase _loginUseCase;

  void _onEmailChanged(
    final LoginEmailChanged event,
    final Emitter<LoginState> emit,
  ) {
    emit(LoginFormChanged(
      email: event.email,
      password: state.password,
    ));
  }

  void _onPasswordChanged(
    final LoginPasswordChanged event,
    final Emitter<LoginState> emit,
  ) {
    emit(LoginFormChanged(
      email: state.email,
      password: event.password,
    ));
  }

  Future<void> _onLoginSubmitted(
    final LoginSubmitted event,
    final Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading(
      email: state.email,
      password: state.password,
    ));

    try {
      final user = await _loginUseCase(
        email: state.email,
        password: state.password,
      );
      emit(LoginSuccess(
        user: user,
        email: state.email,
        password: state.password,
      ));
    } catch (e) {
      emit(LoginFailure(
        message: _getErrorMessage(e),
        email: state.email,
        password: state.password,
      ));
    }
  }

  String _getErrorMessage(final error) {
    if (error is AuthException) {
      return error.message;
    } else if (error is ArgumentError) {
      return error.message;
    }
    return 'Произошла неизвестная ошибка входа';
  }
}
