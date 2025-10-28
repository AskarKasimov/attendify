import 'package:attendify/features/advertising/presentation/bloc/advertising_bloc.dart';
import 'package:attendify/features/advertising/presentation/bloc/advertising_bloc_state.dart';
import 'package:attendify/features/advertising/presentation/bloc/advertising_event.dart';
import 'package:attendify/features/event_join/presentation/bloc/event_join_bloc.dart';
import 'package:attendify/features/event_join/presentation/bloc/event_join_state.dart';
import 'package:attendify/shared/di/injection_container.dart';
import 'package:attendify/shared/ui_kit/components/app_button.dart';
import 'package:attendify/shared/ui_kit/components/app_components.dart';
import 'package:attendify/shared/ui_kit/components/status_card.dart';
import 'package:attendify/shared/ui_kit/theme/app_colors.dart';
import 'package:attendify/shared/ui_kit/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvertisingPage extends StatelessWidget {
  const AdvertisingPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider.value(
    value: sl<AdvertisingBloc>(),
    child: const AdvertisingView(),
  );
}

class AdvertisingView extends StatelessWidget {
  const AdvertisingView({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    appBar: AppBar(
      title: Text(
        'Режим маячка',
        style: AppTextStyles.titleLarge.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: AppColors.background,
      elevation: 0,
    ),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildAdvertisingButton(context),
          const SizedBox(height: 24),
          Expanded(child: _buildStatusArea()),
        ],
      ),
    ),
  );

  Widget _buildHeader() => Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(
            Icons.radio_button_checked,
            size: 48,
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Стать маячком для других участников',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Ваше устройство будет видно другим участникам события',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          BlocBuilder<EventJoinBloc, EventJoinState>(
            bloc: sl<EventJoinBloc>(),
            builder: (final context, final state) {
              if (state is EventJoinSuccessState) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'PIN код события',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.pin
                            .replaceAllMapped(
                              RegExp(r'(\d)'),
                              (final match) => '${match.group(1)} ',
                            )
                            .trim(),
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    ),
  );

  Widget _buildAdvertisingButton(final BuildContext context) =>
      BlocBuilder<AdvertisingBloc, AdvertisingBlocState>(
        builder: (final context, final state) {
          final isActive = state is AdvertisingActiveState;
          final isStarting = state is AdvertisingStartingState;
          final isStopping = state is AdvertisingStoppingState;
          final isProcessing = isStarting || isStopping;

          if (isActive) {
            return AppButton.important(
              onPressed: isProcessing
                  ? null
                  : () {
                      context.read<AdvertisingBloc>().add(
                        const StopAdvertisingEvent(),
                      );
                    },
              text: _getButtonText(state),
              isLoading: isStopping,
              isFullWidth: true,
              icon: Icons.stop,
            );
          }

          return AppButton.primary(
            onPressed: isProcessing
                ? null
                : () {
                    context.read<AdvertisingBloc>().add(
                      const StartAdvertisingEvent(),
                    );
                  },
            text: _getButtonText(state),
            isLoading: isStarting,
            isFullWidth: true,
            icon: Icons.radio_button_checked,
          );
        },
      );

  Widget
  _buildStatusArea() => BlocBuilder<AdvertisingBloc, AdvertisingBlocState>(
    builder: (final context, final state) {
      if (state is AdvertisingInitialState) {
        return const Center(
          child: StatusCard(
            icon: Icons.radio_button_unchecked,
            title: 'Готов к работе',
            subtitle:
                'Нажмите "Стать маячком" чтобы другие участники могли вас найти',
            iconColor: AppColors.textSecondary,
            titleColor: AppColors.textSecondary,
          ),
        );
      }

      if (state is AdvertisingStartingState) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLoadingIndicator(size: 64),
              const SizedBox(height: 16),
              Text(
                'Запуск маячка...',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        );
      }

      if (state is AdvertisingActiveState) {
        return Center(
          child: StatusCard(
            icon: Icons.radio_button_checked,
            title: 'Маячок активен!',
            subtitle: 'Хост может подтвердить ваше присутствие',
            iconColor: AppColors.primary,
            titleColor: AppColors.primary,
            backgroundColor: AppColors.primary.withValues(alpha: 0.05),
          ),
        );
      }

      if (state is AdvertisingStoppingState) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLoadingIndicator(size: 64),
              const SizedBox(height: 16),
              Text(
                'Остановка маячка...',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        );
      }

      if (state is AdvertisingErrorState) {
        return Center(
          child: Column(
            children: [
              StatusCard(
                icon: Icons.error,
                title: 'Ошибка маячка',
                subtitle: state.message,
                iconColor: AppColors.error,
                titleColor: AppColors.error,
                backgroundColor: AppColors.error.withValues(alpha: 0.05),
              ),
              const SizedBox(height: 16),
              AppButton.outline(
                onPressed: () {
                  context.read<AdvertisingBloc>().add(
                    const ResetAdvertisingEvent(),
                  );
                },
                text: 'Попробовать снова',
                isFullWidth: true,
              ),
            ],
          ),
        );
      }

      // Fallback для неизвестного состояния
      return const Center(
        child: StatusCard(
          icon: Icons.help,
          title: 'Неизвестное состояние',
          subtitle: 'Что-то пошло не так',
          iconColor: AppColors.textSecondary,
          titleColor: AppColors.textSecondary,
        ),
      );
    },
  );

  String _getButtonText(final AdvertisingBlocState state) {
    if (state is AdvertisingStartingState) {
      return 'Запуск...';
    }
    if (state is AdvertisingStoppingState) {
      return 'Остановка...';
    }
    if (state is AdvertisingActiveState) {
      return 'Остановить маячок';
    }
    return 'Стать маячком';
  }
}
