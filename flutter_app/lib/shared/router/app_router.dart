import 'package:attendify/features/advertising/presentation/pages/advertising_page.dart';
import 'package:attendify/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:attendify/features/auth/presentation/pages/login_page.dart';
import 'package:attendify/features/auth/presentation/pages/register_page.dart';
import 'package:attendify/features/auth/presentation/pages/splash_screen.dart';
import 'package:attendify/features/event_join/presentation/pages/event_join_page.dart';
import 'package:attendify/features/home/presentation/pages/home_page.dart';
import 'package:attendify/features/scanning/presentation/pages/scanning_page.dart';
import 'package:attendify/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String scanning = '/scanning';
  static const String advertising = '/advertising';
  static const String eventJoin = '/event-join';

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
      GoRoute(
        path: settings,
        name: 'settings',
        builder: (final context, final state) => const SettingsPage(),
      ),
      GoRoute(
        path: scanning,
        name: 'scanning',
        builder: (final context, final state) => const ScanningPage(),
      ),
      GoRoute(
        path: advertising,
        name: 'advertising',
        builder: (final context, final state) => const AdvertisingPage(),
      ),
      GoRoute(
        path: eventJoin,
        name: 'event-join',
        builder: (final context, final state) => const EventJoinPage(),
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
