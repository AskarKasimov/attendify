import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_app/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_app/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/';

  static GoRouter createRouter(final AuthBloc authBloc) => GoRouter(
    initialLocation: login,
    redirect: (final context, final state) {
      final authState = authBloc.state;
      final isLoginPage = state.matchedLocation == login;
      final isRegisterPage = state.matchedLocation == register;
      final isAuthPage = isLoginPage || isRegisterPage;

      // If user is authenticated and trying to access auth pages, redirect to home
      if (authState is AuthAuthenticated && isAuthPage) {
        return home;
      }

      // If user is not authenticated and not on auth pages, redirect to login
      if (authState is! AuthAuthenticated && !isAuthPage) {
        return login;
      }

      // No redirect needed
      return null;
    },
    refreshListenable: AuthStateNotifier(authBloc),
    routes: [
      GoRoute(
        path: login,
        name: 'login',
        builder: (final context, final state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (final context, final state) => const RegisterPage(),
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (final context, final state) => const HomePage(),
      ),
    ],
  );
}

class AuthStateNotifier extends ChangeNotifier {
  AuthStateNotifier(this._authBloc) {
    _authBloc.stream.listen((_) {
      notifyListeners();
    });
  }

  final AuthBloc _authBloc;
}
