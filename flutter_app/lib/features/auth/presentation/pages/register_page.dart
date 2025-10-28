import 'package:attendify/features/auth/domain/value_objects/auth_value_objects.dart';
import 'package:attendify/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:attendify/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:attendify/shared/di/injection_container.dart' as di;
import 'package:attendify/shared/ui_kit/components/app_button.dart';
import 'package:attendify/shared/ui_kit/components/app_input.dart';
import 'package:attendify/shared/ui_kit/theme/app_colors.dart';
import 'package:attendify/shared/ui_kit/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => di.sl<RegisterBloc>(),
    child: const _RegisterPageContent(),
  );
}

class _RegisterPageContent extends StatelessWidget {
  const _RegisterPageContent();

  void _onRegisterPressed(final BuildContext context) {
    context.read<RegisterBloc>().add(const RegisterSubmitted());
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      leading: IconButton(
        onPressed: () async {
          if (context.canPop()) {
            context.pop();
          } else {
            await context.push('/login');
          }
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: const Text('Вернуться ко входу'),
      backgroundColor: AppColors.surface,
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),

                    Text(
                      'Создайте аккаунт',
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Заполните данные для регистрации',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (final context, final state) => AppTextField(
                        controller: TextEditingController(text: state.name),
                        onChanged: (final value) => context
                            .read<RegisterBloc>()
                            .add(RegisterNameChanged(value)),
                        label: 'Имя',
                        placeholder: 'Введите ваше имя',
                        prefixIcon: Icons.person_outline,
                        errorText:
                            (state.name.isNotEmpty ||
                                state.showValidationErrors)
                            ? UserName.validate(state.name)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),

                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (final context, final state) => AppTextField(
                        controller: TextEditingController(text: state.email),
                        onChanged: (final value) => context
                            .read<RegisterBloc>()
                            .add(RegisterEmailChanged(value)),
                        label: 'Email',
                        placeholder: 'Введите ваш email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        errorText:
                            (state.email.isNotEmpty ||
                                state.showValidationErrors)
                            ? Email.validate(state.email)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),

                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (final context, final state) => AppTextField(
                        controller: TextEditingController(text: state.password),
                        onChanged: (final value) => context
                            .read<RegisterBloc>()
                            .add(RegisterPasswordChanged(value)),
                        label: 'Пароль',
                        placeholder: 'Создайте пароль',
                        obscureText: true,
                        prefixIcon: Icons.lock_outline,
                        errorText:
                            (state.password.isNotEmpty ||
                                state.showValidationErrors)
                            ? Password.validate(state.password)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),

                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (final context, final state) => AppTextField(
                        controller: TextEditingController(
                          text: state.confirmPassword,
                        ),
                        onChanged: (final value) => context
                            .read<RegisterBloc>()
                            .add(RegisterConfirmPasswordChanged(value)),
                        label: 'Подтвердите пароль',
                        placeholder: 'Повторите пароль',
                        obscureText: true,
                        prefixIcon: Icons.lock_outline,
                        errorText:
                            (state.confirmPassword.isNotEmpty ||
                                state.showValidationErrors)
                            ? ConfirmPassword.validate(
                                state.password,
                                state.confirmPassword,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            BlocConsumer<RegisterBloc, RegisterState>(
              listener: (final context, final state) {
                switch (state) {
                  case RegisterFailure():
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  case RegisterSuccess():
                    // глобальный auth bloc
                    context.read<AuthBloc>().add(AuthenticateUser(state.user));
                    context.go('/home');
                  default:
                    break;
                }
              },
              builder: (final context, final state) => AppButton.outline(
                onPressed: state is RegisterLoading
                    ? null
                    : () => _onRegisterPressed(context),
                text: 'Зарегистрироваться',
                isLoading: state is RegisterLoading,
                isFullWidth: true,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
