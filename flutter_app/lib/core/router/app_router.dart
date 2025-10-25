import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_app/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_app/features/auth/presentation/pages/splash_screen.dart';
import 'package:flutter_app/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static GoRouter createRouter(final AuthBloc authBloc) => GoRouter(
    initialLocation: splash,
    // Убираем глобальные редиректы - теперь SplashScreen сам управляет навигацией
    refreshListenable: AuthStateNotifier(authBloc),
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (final context, final state) => const SplashScreen(),
      ),
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
