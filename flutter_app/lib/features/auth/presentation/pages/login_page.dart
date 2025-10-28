import 'package:attendify/features/auth/domain/value_objects/auth_value_objects.dart';
import 'package:attendify/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:attendify/features/auth/presentation/bloc/logic_bloc/login_bloc.dart';
import 'package:attendify/shared/di/injection_container.dart' as di;
import 'package:attendify/shared/ui_kit/components/app_button.dart';
import 'package:attendify/shared/ui_kit/components/app_input.dart';
import 'package:attendify/shared/ui_kit/components/app_modal.dart';
import 'package:attendify/shared/ui_kit/theme/app_colors.dart';
import 'package:attendify/shared/ui_kit/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => di.sl<LoginBloc>(),
    child: const _LoginPageContent(),
  );
}

class _LoginPageContent extends StatelessWidget {
  const _LoginPageContent();

  void _onLoginPressed(final BuildContext context) {
    context.read<LoginBloc>().add(const LoginSubmitted());
  }

  @override
  Widget build(final BuildContext context) => GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Attendify',
                style: AppTextStyles.displaySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Войдите в свою учетную запись',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              BlocBuilder<LoginBloc, LoginState>(
                builder: (final context, final state) => AppTextField(
                  controller: TextEditingController(text: state.email),
                  onChanged: (final value) =>
                      context.read<LoginBloc>().add(LoginEmailChanged(value)),
                  label: 'Email',
                  placeholder: 'Введите ваш email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  errorText:
                      (state.email.isNotEmpty || state.showValidationErrors)
                      ? Email.validate(state.email)
                      : null,
                ),
              ),
              const SizedBox(height: 16),

              BlocBuilder<LoginBloc, LoginState>(
                builder: (final context, final state) => AppTextField(
                  controller: TextEditingController(text: state.password),
                  onChanged: (final value) => context.read<LoginBloc>().add(
                    LoginPasswordChanged(value),
                  ),
                  label: 'Пароль',
                  placeholder: 'Введите ваш пароль',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  errorText:
                      (state.password.isNotEmpty || state.showValidationErrors)
                      ? Password.validate(state.password)
                      : null,
                ),
              ),
              const SizedBox(height: 32),

              BlocConsumer<LoginBloc, LoginState>(
                listener: (final context, final state) {
                  switch (state) {
                    case LoginFailure():
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColors.error,
                        ),
                      );
                    case LoginSuccess():
                      // глобальный auth bloc
                      context.read<AuthBloc>().add(
                        AuthenticateUser(state.user),
                      );
                      context.go('/home');
                    default:
                      break;
                  }
                },
                builder: (final context, final state) => AppButton.primary(
                  onPressed: state is LoginLoading
                      ? null
                      : () => _onLoginPressed(context),
                  text: 'Войти',
                  isLoading: state is LoginLoading,
                  isFullWidth: true,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'ИЛИ',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),

              BlocListener<AuthBloc, AuthState>(
                listener: (final context, final state) {
                  if (state is AuthAuthenticated) {
                    AppLoadingDialog.hide(context);
                    context.go('/home');
                  } else if (state is AuthUnauthenticated &&
                      state.errorMessage != null) {
                    AppLoadingDialog.hide(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage!),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  }
                },
                child: AppButton.outline(
                  onPressed: () {
                    // модалка на фоне должна крутиться
                    // ignore: discarded_futures
                    AppLoadingDialog.show(
                      context: context,
                      message: 'Авторизация через Authentic...',
                    );
                    context.read<AuthBloc>().add(const AuthenticOAuthLogin());
                  },
                  text: 'Войти через Authentic',
                  isFullWidth: true,
                  icon: Icons.security,
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Нет аккаунта? ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await context.push('/register');
                    },
                    child: Text(
                      'Зарегистрироваться',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
