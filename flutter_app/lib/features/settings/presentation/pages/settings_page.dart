import 'dart:async';

import 'package:attendify/features/auth/domain/entities/user.dart';
import 'package:attendify/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:attendify/shared/ui_kit/components/app_button.dart';
import 'package:attendify/shared/ui_kit/components/app_components.dart';
import 'package:attendify/shared/ui_kit/components/app_modal.dart';
import 'package:attendify/shared/ui_kit/theme/app_colors.dart';
import 'package:attendify/shared/ui_kit/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (final context, final state) {
          switch (state) {
            case AuthAuthenticated():
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: UserProfileCard(user: state.user),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(24),
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Общие',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SettingsItem(
                          icon: Icons.language_outlined,
                          title: 'Язык',
                          subtitle: 'Русский',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Выбор языка - в разработке'),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        SettingsItem(
                          icon: Icons.dark_mode_outlined,
                          title: 'Тема оформления',
                          subtitle: 'Светлая',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Выбор темы - в разработке'),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Приложение',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SettingsItem(
                          icon: Icons.help_outline,
                          title: 'Помощь',
                          subtitle: 'FAQ и поддержка',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Раздел помощи - в разработке'),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        SettingsItem(
                          icon: Icons.info_outline,
                          title: 'О приложении',
                          subtitle: 'Версия 1.0.0',
                          onTap: () {},
                        ),
                        const SizedBox(height: 32),
                        const LogoutButton(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
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

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({required this.user, super.key});

  final User user;

  @override
  Widget build(final BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: AppColors.primary,
          child: Text(
            user.displayName.isNotEmpty
                ? user.displayName[0].toUpperCase()
                : '?',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.displayName,
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user.email.value,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) => Card(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    ),
  );
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(final BuildContext context) => Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    child: OutlinedButton.icon(
      onPressed: () {
        _showLogoutDialog(context);
      },
      icon: const Icon(Icons.logout, color: Colors.red),
      label: Text(
        'Выйти из аккаунта',
        style: AppTextStyles.bodyLarge.copyWith(
          color: Colors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}

void _showLogoutDialog(final BuildContext context) {
  unawaited(
    showDialog<void>(
      context: context,
      builder: (final dialogContext) => AppDialog(
        title: 'Выход из аккаунта',
        icon: Icons.logout,
        content: const Text('Вы уверены, что хотите выйти из аккаунта?'),
        actions: [
          AppButton.outline(
            onPressed: () => Navigator.of(dialogContext).pop(),
            text: 'Отмена',
          ),
          AppButton.important(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AuthBloc>().add(const Logout());
            },
            text: 'Выйти',
          ),
        ],
      ),
    ),
  );
}
