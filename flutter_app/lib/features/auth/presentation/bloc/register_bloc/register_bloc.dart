import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/errors/auth_exception.dart';
import 'package:attendify/features/auth/domain/usecases/register_usecase.dart';
import 'package:attendify/shared/errors/validation_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required final RegisterUseCase registerUseCase})
    : _registerUseCase = registerUseCase,
      super(const RegisterInitial()) {
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RegisterValidationRequested>(_onValidationRequested);
  }

  final RegisterUseCase _registerUseCase;

  void _onNameChanged(
    final RegisterNameChanged event,
    final Emitter<RegisterState> emit,
  ) {
    emit(
      RegisterFormChanged(
        name: event.name,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
      ),
    );
  }

  void _onEmailChanged(
    final RegisterEmailChanged event,
    final Emitter<RegisterState> emit,
  ) {
    emit(
      RegisterFormChanged(
        name: state.name,
        email: event.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
      ),
    );
  }

  void _onPasswordChanged(
    final RegisterPasswordChanged event,
    final Emitter<RegisterState> emit,
  ) {
    emit(
      RegisterFormChanged(
        name: state.name,
        email: state.email,
        password: event.password,
        confirmPassword: state.confirmPassword,
      ),
    );
  }

  void _onConfirmPasswordChanged(
    final RegisterConfirmPasswordChanged event,
    final Emitter<RegisterState> emit,
  ) {
    emit(
      RegisterFormChanged(
        name: state.name,
        email: state.email,
        password: state.password,
        confirmPassword: event.confirmPassword,
      ),
    );
  }

  Future<void> _onRegisterSubmitted(
    final RegisterSubmitted event,
    final Emitter<RegisterState> emit,
  ) async {
    emit(
      RegisterLoading(
        name: state.name,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
      ),
    );

    try {
      final user = await _registerUseCase(
        email: state.email,
        password: state.password,
        name: state.name,
        confirmPassword: state.confirmPassword,
      );
      emit(
        RegisterSuccess(
          user: user,
          name: state.name,
          email: state.email,
          password: state.password,
          confirmPassword: state.confirmPassword,
        ),
      );
    } on ValidationException {
      // если ошибка валидации, показываем в инпутах
      emit(
        RegisterFormChanged(
          name: state.name,
          email: state.email,
          password: state.password,
          confirmPassword: state.confirmPassword,
          showValidationErrors: true,
        ),
      );
    } catch (e) {
      emit(
        RegisterFailure(
          message: _getErrorMessage(e),
          name: state.name,
          email: state.email,
          password: state.password,
          confirmPassword: state.confirmPassword,
        ),
      );
    }
  }

  void _onValidationRequested(
    final RegisterValidationRequested event,
    final Emitter<RegisterState> emit,
  ) {
    emit(
      RegisterFormChanged(
        name: state.name,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
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
    return 'Произошла неизвестная ошибка регистрации';
  }
}
