import 'package:attendify/ui_kit/components/app_components.dart';
import 'package:attendify/ui_kit/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton.primary({
    required this.onPressed,
    required final String text,
    super.key,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.tooltip,
  }) : child = Text(text),
       backgroundColor = AppColors.primary,
       foregroundColor = AppColors.onPrimary,
       borderColor = null,
       isIconOnly = false;

  AppButton.outline({
    required this.onPressed,
    required final String text,
    super.key,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.tooltip,
  }) : child = Text(text),
       backgroundColor = Colors.transparent,
       foregroundColor = AppColors.primary,
       borderColor = AppColors.primary,
       isIconOnly = false;

  AppButton.important({
    required this.onPressed,
    required final String text,
    super.key,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.tooltip,
  }) : child = Text(text),
       backgroundColor = AppColors.error,
       foregroundColor = Colors.white,
       borderColor = null,
       isIconOnly = false;

  AppButton.iconPrimary({
    required this.onPressed,
    required final IconData iconData,
    super.key,
    this.tooltip,
  }) : child = Icon(iconData, size: 20),
       backgroundColor = AppColors.primary,
       foregroundColor = AppColors.onPrimary,
       borderColor = null,
       isIconOnly = true,
       isLoading = false,
       isFullWidth = false,
       icon = null;

  AppButton.iconOutline({
    required this.onPressed,
    required final IconData iconData,
    super.key,
    this.tooltip,
  }) : child = Icon(iconData, size: 20),
       backgroundColor = Colors.transparent,
       foregroundColor = AppColors.primary,
       borderColor = AppColors.primary,
       isIconOnly = true,
       isLoading = false,
       isFullWidth = false,
       icon = null;

  AppButton.iconImportant({
    required this.onPressed,
    required final IconData iconData,
    super.key,
    this.tooltip,
  }) : child = Icon(iconData, size: 20),
       backgroundColor = AppColors.error,
       foregroundColor = Colors.white,
       borderColor = null,
       isIconOnly = true,
       isLoading = false,
       isFullWidth = false,
       icon = null;

  final VoidCallback? onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final String? tooltip;
  final bool isIconOnly;

  @override
  Widget build(final BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    Widget button;

    if (isIconOnly) {
      button = SizedBox(
        width: 48,
        height: 48,
        child: _AppButtonWidget(
          onPressed: isEnabled ? onPressed : null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          borderColor: borderColor,
          padding: EdgeInsets.zero,
          child: child,
        ),
      );
    } else {
      button = SizedBox(
        width: isFullWidth ? double.infinity : null,
        height: 48,
        child: _AppButtonWidget(
          onPressed: isEnabled ? onPressed : null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          borderColor: borderColor,
          child: _AppButtonContent(
            isLoading: isLoading,
            icon: icon,
            child: child,
          ),
        ),
      );
    }

    if (tooltip != null) {
      return Tooltip(message: tooltip, child: button);
    }
    return button;
  }
}

class _AppButtonWidget extends StatelessWidget {
  const _AppButtonWidget({
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.child,
    this.borderColor,
    this.padding,
  });

  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final Widget child;

  @override
  Widget build(final BuildContext context) {
    if (borderColor != null) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
          side: BorderSide(color: borderColor!),
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: child,
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: child,
    );
  }
}

class _AppButtonContent extends StatelessWidget {
  const _AppButtonContent({
    required this.child,
    this.isLoading = false,
    this.icon,
  });

  final Widget child;
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(final BuildContext context) {
    if (isLoading) {
      return const AppLoadingIndicator(size: 24);
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 18), const SizedBox(width: 8), child],
      );
    }

    return child;
  }
}
