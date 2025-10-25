import 'package:flutter/material.dart';
import 'package:flutter_app/ui_kit/components/app_button.dart';
import 'package:flutter_app/ui_kit/theme/app_colors.dart';
import 'package:flutter_app/ui_kit/theme/app_text_styles.dart';

/// стандартная модалка
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.icon,
    this.width,
    this.isDismissible = true,
  });

  final String? title;
  final Widget? content;
  final List<Widget>? actions;
  final IconData? icon;
  final double? width;
  final bool isDismissible;

  static Future<void> showInfo({
    required final BuildContext context,
    final String? title,
    final String? message,
    final String buttonText = 'OK',
    final IconData? icon,
  }) => showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (final context) => AppDialog(
      title: title,
      icon: icon,
      content: message != null ? Text(message) : null,
      actions: [
        AppButton.primary(
          onPressed: () => Navigator.of(context).pop(),
          text: buttonText,
        ),
      ],
    ),
  );

  @override
  Widget build(final BuildContext context) => Dialog(
    backgroundColor: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    elevation: 8,
    shadowColor: AppColors.shadow,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      width: width,
      constraints: const BoxConstraints(minWidth: 280, maxWidth: 400),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null || title != null) ...[
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 24, color: AppColors.primary),
                  const SizedBox(width: 12),
                ],
                if (title != null)
                  Expanded(
                    child: Text(
                      title!,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
              ],
            ),
            if (content != null) const SizedBox(height: 16),
          ],
          if (content != null) ...[
            DefaultTextStyle(
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
              child: content!,
            ),
          ],
          if (actions != null && actions!.isNotEmpty) ...[
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (int i = 0; i < actions!.length; i++) ...[
                  if (i > 0) const SizedBox(width: 12),
                  actions![i],
                ],
              ],
            ),
          ],
        ],
      ),
    ),
  );
}

/// модалка с загрузкой
class AppLoadingDialog extends StatelessWidget {
  const AppLoadingDialog({super.key, this.message = 'Загрузка...'});

  final String message;

  /// показать модалку загрузки
  static Future<void> show({
    required final BuildContext context,
    final String message = 'Загрузка...',
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (final context) => AppLoadingDialog(message: message),
    );
  }

  /// скрыть модалку загрузки
  static void hide(final BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(final BuildContext context) => Dialog(
    backgroundColor: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    elevation: 8,
    shadowColor: AppColors.shadow,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
