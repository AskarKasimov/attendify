import 'package:attendify/features/event_join/presentation/bloc/event_join_bloc.dart';
import 'package:attendify/features/event_join/presentation/bloc/event_join_event.dart';
import 'package:attendify/features/event_join/presentation/bloc/event_join_state.dart';
import 'package:attendify/shared/di/injection_container.dart';
import 'package:attendify/shared/ui_kit/components/app_button.dart';
import 'package:attendify/shared/ui_kit/components/app_components.dart';
import 'package:attendify/shared/ui_kit/components/app_pin_input.dart';
import 'package:attendify/shared/ui_kit/components/status_card.dart';
import 'package:attendify/shared/ui_kit/theme/app_colors.dart';
import 'package:attendify/shared/ui_kit/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EventJoinPage extends StatelessWidget {
  const EventJoinPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider.value(
    value: sl<EventJoinBloc>(),
    child: const EventJoinView(),
  );
}

class EventJoinView extends StatelessWidget {
  const EventJoinView({super.key});

  @override
  Widget build(final BuildContext context) => GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Присоединиться к событию',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildPinInput(context),
            const SizedBox(height: 24),
            _buildJoinButton(context),
            const SizedBox(height: 32),
            _buildStatusArea(context),
          ],
        ),
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
          const Icon(Icons.pin_drop, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            'Введите PIN код',
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'PIN код состоит из 6 цифр и предоставляется организатором события',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );

  Widget _buildPinInput(final BuildContext context) =>
      BlocBuilder<EventJoinBloc, EventJoinState>(
        builder: (final context, final state) => AppPinCodeInput(
          length: 6,
          onChanged: (final pin) {
            context.read<EventJoinBloc>().add(PinChangedEvent(pin));
          },
          errorText: state is EventJoinErrorState ? state.message : null,
        ),
      );

  Widget _buildJoinButton(final BuildContext context) =>
      BlocBuilder<EventJoinBloc, EventJoinState>(
        builder: (final context, final state) => AppButton.primary(
          onPressed: state.canJoin
              ? () => context.read<EventJoinBloc>().add(
                  const JoinRequestedEvent(),
                )
              : null,
          text: 'Присоединиться',
          isLoading: state.isLoading,
          isFullWidth: true,
          icon: Icons.login,
        ),
      );

  Widget _buildStatusArea(
    final BuildContext context,
  ) => BlocBuilder<EventJoinBloc, EventJoinState>(
    builder: (final context, final state) {
      if (state is EventJoinInitialState || state is EventJoinPinChangedState) {
        return const SizedBox.shrink();
      }

      if (state is EventJoinLoadingState) {
        return const Center(
          child: Column(
            children: [
              AppLoadingIndicator(size: 64),
              SizedBox(height: 16),
              Text(
                'Проверяем PIN код...',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
            ],
          ),
        );
      }

      if (state is EventJoinSuccessState) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await context.push('/advertising');
        });

        return Column(
          children: [
            StatusCard(
              icon: Icons.check_circle,
              title: 'Успешно!',
              subtitle: 'Добро пожаловать в "${state.response.eventName}"',
              iconColor: AppColors.primary,
              titleColor: AppColors.primary,
              backgroundColor: AppColors.primary.withValues(alpha: 0.05),
            ),
            const SizedBox(height: 16),
            Text(
              'Переход к режиму маячка...',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }

      if (state is EventJoinErrorState) {
        return Column(
          children: [
            StatusCard(
              icon: Icons.error,
              title: 'Ошибка',
              subtitle: state.message,
              iconColor: AppColors.error,
              titleColor: AppColors.error,
              backgroundColor: AppColors.error.withValues(alpha: 0.05),
            ),
            const SizedBox(height: 16),
            AppButton.outline(
              onPressed: () =>
                  context.read<EventJoinBloc>().add(const ResetStateEvent()),
              text: 'Попробовать снова',
              isFullWidth: true,
            ),
          ],
        );
      }

      return const SizedBox.shrink();
    },
  );
}
