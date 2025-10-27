import 'dart:async';

import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/domain/usecases/authentic_login_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/logout_usecase.dart';
import 'package:attendify/shared/services/auth_event_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required final LogoutUseCase logoutUseCase,
    required final GetCurrentUserUseCase getCurrentUserUseCase,
    required final AuthenticLoginUseCase authenticLoginUseCase,
    required final AuthEventService authEventService,
  }) : _logoutUseCase = logoutUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       _authenticLoginUseCase = authenticLoginUseCase,
       _authEventService = authEventService,
       super(const AuthInitial()) {
    _authEventSubscription = _authEventService.events.listen((final event) {
      if (event == AuthEventType.sessionExpired) {
        add(const SessionExpired());
      }
    });
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
        case SessionExpired():
          await _onSessionExpired(emit);
      }
    });
  }

  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final AuthenticLoginUseCase _authenticLoginUseCase;
  final AuthEventService _authEventService;
  late final StreamSubscription _authEventSubscription;

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

  Future<void> _onSessionExpired(final Emitter<AuthState> emit) async {
    emit(const AuthUnauthenticated());
  }

  @override
  Future<void> close() async {
    await _authEventSubscription.cancel();
    return super.close();
  }
}
