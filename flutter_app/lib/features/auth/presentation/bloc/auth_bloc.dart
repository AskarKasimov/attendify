import 'package:attendify/core/errors/auth_exceptions.dart';
import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/login_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/logout_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required final LoginUseCase loginUseCase,
    required final LogoutUseCase logoutUseCase,
    required final RegisterUseCase registerUseCase,
    required final GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _loginUseCase = loginUseCase,
       _logoutUseCase = logoutUseCase,
       _registerUseCase = registerUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       super(const AuthInitial()) {
    on<AuthEvent>((final event, final emit) async {
      switch (event) {
        case CheckAuthStatus():
          await _onCheckAuthStatus(emit);
        case Login(:final email, :final password):
          await _onLogin(email, password, emit);
        case Register(:final email, :final password, :final name):
          await _onRegister(email, password, name, emit);
        case Logout():
          await _onLogout(emit);
      }
    });
  }

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final RegisterUseCase _registerUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  Future<void> _onCheckAuthStatus(final Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final user = await _getCurrentUserUseCase();

      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onLogin(
    final String email,
    final String password,
    final Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final user = await _loginUseCase(email: email, password: password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthUnauthenticated(_getErrorMessage(e)));
    }
  }

  Future<void> _onRegister(
    final String email,
    final String password,
    final String name,
    final Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final user = await _registerUseCase(
        email: email,
        password: password,
        name: name,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthUnauthenticated(_getErrorMessage(e)));
    }
  }

  Future<void> _onLogout(final Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      await _logoutUseCase();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthUnauthenticated(_getErrorMessage(e)));
    }
  }

  String _getErrorMessage(final error) {
    if (error is AuthException) {
      return error.message;
    } else if (error is ArgumentError) {
      return error.message;
    }
    return 'Произошла неизвестная ошибка';
  }
}
