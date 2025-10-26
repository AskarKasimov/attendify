import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/usecases/authentic_login_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required final LogoutUseCase logoutUseCase,
    required final GetCurrentUserUseCase getCurrentUserUseCase,
    required final AuthenticLoginUseCase authenticLoginUseCase,
  }) : _logoutUseCase = logoutUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       _authenticLoginUseCase = authenticLoginUseCase,
       super(const AuthInitial()) {
    on<AuthEvent>((final event, final emit) async {
      switch (event) {
        case CheckAuthStatus():
          await _onCheckAuthStatus(emit);
        case AuthenticateUser(:final user):
          emit(AuthAuthenticated(user));
        case Logout():
          await _onLogout(emit);
        case AuthenticOAuthLogin():
          await _onAuthenticOAuthLogin(emit);
      }
    });
  }

  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final AuthenticLoginUseCase _authenticLoginUseCase;

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

  Future<void> _onLogout(final Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      await _logoutUseCase();
    } finally {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onAuthenticOAuthLogin(final Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final user = await _authenticLoginUseCase();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }
}
