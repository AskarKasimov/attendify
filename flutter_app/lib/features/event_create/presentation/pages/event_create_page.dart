import 'package:attendify/features/event_create/presentation/bloc/event_create_bloc.dart';
import 'package:attendify/features/event_create/presentation/bloc/event_create_event.dart';
import 'package:attendify/features/event_create/presentation/bloc/event_create_state.dart';
import 'package:attendify/shared/di/injection_container.dart';
import 'package:attendify/shared/ui_kit/components/app_button.dart';
import 'package:attendify/shared/ui_kit/theme/app_colors.dart';
import 'package:attendify/shared/ui_kit/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EventCreatePage extends StatelessWidget {
  const EventCreatePage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (_) => sl<EventCreateBloc>(),
    child: const EventCreateView(),
  );
}

class EventCreateView extends StatelessWidget {
  const EventCreateView({super.key});

  @override
  Widget build(final BuildContext context) => GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Создать событие',
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
        child: BlocListener<EventCreateBloc, EventCreateState>(
          listener: (final context, final state) {
            if (state is EventCreateSuccessState) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await context.push(
                  '/scanning',
                  extra: {
                    'eventId': state.response.eventId,
                    'eventPin': state.response.pin,
                  },
                );
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildNameInput(context),
              const SizedBox(height: 24),
              _buildCreateButton(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _buildNameInput(final BuildContext context) =>
      BlocBuilder<EventCreateBloc, EventCreateState>(
        builder: (final context, final state) => TextField(
          decoration: InputDecoration(
            labelText: 'Название события',
            border: const OutlineInputBorder(),
            errorText: state is EventCreateErrorState ? state.message : null,
          ),
          onChanged: (final name) =>
              context.read<EventCreateBloc>().add(EventNameChangedEvent(name)),
        ),
      );

  Widget _buildCreateButton(final BuildContext context) =>
      BlocBuilder<EventCreateBloc, EventCreateState>(
        builder: (final context, final state) => AppButton.primary(
          onPressed:
              state is EventCreateNameChangedState && state.name.isNotEmpty
              ? () =>
                    context.read<EventCreateBloc>().add(CreateRequestedEvent())
              : null,
          text: 'Создать',
          isLoading: state is EventCreateLoadingState,
          isFullWidth: true,
          icon: Icons.add,
        ),
      );
}
