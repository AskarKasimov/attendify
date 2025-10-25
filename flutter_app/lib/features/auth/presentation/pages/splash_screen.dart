import 'package:attendify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:attendify/ui_kit/components/app_components.dart';
import 'package:attendify/ui_kit/theme/app_colors.dart';
import 'package:attendify/ui_kit/theme/app_text_styles.dart';
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
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.event_available,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),

            Text(
              'Attendify',
              style: AppTextStyles.displaySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'Управление посещаемостью',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 48),

            const AppLoadingIndicator(),
          ],
        ),
      ),
    ),
  );
}
