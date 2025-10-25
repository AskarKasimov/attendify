import 'package:flutter/material.dart';
import 'package:flutter_app/ui_kit/theme/app_colors.dart';

/// спиннер
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.size,
    this.strokeWidth = 2.5,
    this.color,
  });

  final double? size;
  final double strokeWidth;
  final Color? color;

  @override
  Widget build(final BuildContext context) {
    final indicator = CircularProgressIndicator(
      strokeWidth: strokeWidth,
      valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
    );

    if (size != null) {
      return SizedBox(width: size, height: size, child: indicator);
    }

    return indicator;
  }
}
