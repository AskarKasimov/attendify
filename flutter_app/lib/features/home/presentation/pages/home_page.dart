import 'package:attendify/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:attendify/shared/ui_kit/components/action_card.dart';
import 'package:attendify/shared/ui_kit/components/app_components.dart';
import 'package:attendify/shared/ui_kit/components/mini_action_card.dart';
import 'package:attendify/shared/ui_kit/theme/app_colors.dart';
import 'package:attendify/shared/ui_kit/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) => BlocListener<AuthBloc, AuthState>(
    listener: (final context, final state) {
      switch (state) {
        case AuthUnauthenticated():
          if (context.mounted) {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (context.mounted) {
                context.go('/login');
              }
            });
          }
        default:
          break;
      }
    },
    child: Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.background),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (final context, final state) {
          switch (state) {
            case AuthAuthenticated():
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Добро пожаловать,',
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      state.user.displayName,
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Управление посещаемостью мероприятий',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Быстрые действия',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ActionCard(
                      icon: Icons.add_circle_outline,
                      title: 'Создать событие',
                      description: 'Новое мероприятие для отметок',
                      isPrimary: true,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Создание события - в разработке'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    ActionCard(
                      icon: Icons.qr_code_scanner,
                      title: 'Отметиться',
                      description: 'Сканировать QR код события',
                      isPrimary: true,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('QR сканер - в разработке'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: MiniActionCard(
                            icon: Icons.history,
                            title: 'События',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'История событий - в разработке',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: MiniActionCard(
                            icon: Icons.settings_outlined,
                            title: 'Настройки',
                            onTap: () {
                              context.go('/settings');
                            },
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              );
            case AuthLoading():
            case AuthInitial():
            case AuthUnauthenticated():
              return const Center(child: AppLoadingIndicator());
          }
        },
      ),
    ),
  );
}
