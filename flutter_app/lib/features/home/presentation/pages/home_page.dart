import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_app/ui_kit/theme/app_colors.dart';
import 'package:flutter_app/ui_kit/theme/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    appBar: AppBar(
      title: const Text('Attendify'),
      backgroundColor: AppColors.surface,
      actions: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (final context, final state) {
            if (state is AuthAuthenticated) {
              return PopupMenuButton<String>(
                onSelected: (final value) {
                  if (value == 'logout') {
                    context.read<AuthBloc>().add(const Logout());
                  }
                },
                itemBuilder: (final context) => [
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 8),
                        Text('Выйти'),
                      ],
                    ),
                  ),
                ],
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          state.user.displayName.isNotEmpty
                              ? state.user.displayName[0].toUpperCase()
                              : '?',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    ),
    body: BlocBuilder<AuthBloc, AuthState>(
      builder: (final context, final state) {
        if (state is AuthAuthenticated) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome message
                Text(
                  'Добро пожаловать, ${state.user.displayName}!',
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Система контроля посещаемости готова к работе.',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),

                // Quick actions
                Text(
                  'Быстрые действия',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                // Action cards
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _ActionCard(
                        icon: Icons.qr_code_scanner,
                        title: 'Сканировать QR',
                        description: 'Отметить посещение',
                        onTap: () {
                          // TODO: Navigate to QR scanner
                        },
                      ),
                      _ActionCard(
                        icon: Icons.analytics_outlined,
                        title: 'Аналитика',
                        description: 'Статистика посещений',
                        onTap: () {
                          // TODO: Navigate to analytics
                        },
                      ),
                      _ActionCard(
                        icon: Icons.people_outline,
                        title: 'Участники',
                        description: 'Управление группами',
                        onTap: () {
                          // TODO: Navigate to participants
                        },
                      ),
                      _ActionCard(
                        icon: Icons.settings_outlined,
                        title: 'Настройки',
                        description: 'Конфигурация',
                        onTap: () {
                          // TODO: Navigate to settings
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    ),
  );
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) => Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(icon, color: AppColors.primary, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
