import 'package:attendify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:attendify/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // проверка аутентификации при запуске приложения
    context.read<AuthBloc>().add(const CheckAuthStatus());
  }

  @override
  Widget build(final BuildContext context) => BlocListener<AuthBloc, AuthState>(
    listener: (final context, final state) {
      switch (state) {
        case AuthAuthenticated():
          context.go('/home');
        case AuthUnauthenticated():
          context.go('/login');
        default:
          break;
      }
    },
    child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Логотип строго по центру экрана (как в нативном splash)
          Center(
            child: Assets.icons.icon.image(
              width: 255,
              height: 255,
            ),
          ),
          // Спиннер в нижней части экрана
          const Positioned(
            left: 0,
            right: 0,
            bottom: 100,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
