import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/usecases/login_usecase.dart';
import 'package:attendify/shared/errors/validation_exception.dart';
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
    on<LoginValidationRequested>(_onValidationRequested);
  }

  final LoginUseCase _loginUseCase;

  void _onEmailChanged(
    final LoginEmailChanged event,
    final Emitter<LoginState> emit,
  ) {
    emit(LoginFormChanged(email: event.email, password: state.password));
  }

  void _onPasswordChanged(
    final LoginPasswordChanged event,
    final Emitter<LoginState> emit,
  ) {
    emit(LoginFormChanged(email: state.email, password: event.password));
  }

  Future<void> _onLoginSubmitted(
    final LoginSubmitted event,
    final Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading(email: state.email, password: state.password));

    try {
      final user = await _loginUseCase(
        email: state.email,
        password: state.password,
      );
      emit(
        LoginSuccess(user: user, email: state.email, password: state.password),
      );
    } catch (e) {
      // Если это ошибка валидации, показываем ошибки в полях
      if (e is ValidationException) {
        emit(
          LoginFormChanged(
            email: state.email,
            password: state.password,
            showValidationErrors: true,
          ),
        );
      } else {
        emit(
          LoginFailure(
            message: _getErrorMessage(e),
            email: state.email,
            password: state.password,
          ),
        );
      }
    }
  }

  void _onValidationRequested(
    final LoginValidationRequested event,
    final Emitter<LoginState> emit,
  ) {
    emit(
      LoginFormChanged(
        email: state.email,
        password: state.password,
        showValidationErrors: true,
      ),
    );
  }

  String _getErrorMessage(final Object error) {
    if (error is AuthException) {
      return error.message;
    } else if (error is ValidationException) {
      return error.message;
    }
    return 'Произошла неизвестная ошибка входа';
  }
}
