import 'package:attendify/shared/ui_kit/theme/app_colors.dart';
import 'package:attendify/shared/ui_kit/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.backgroundColor,
    this.iconColor,
    this.titleColor,
    this.subtitleColor,
    this.details = const [],
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final List<StatusDetail> details;

  @override
  Widget build(final BuildContext context) => Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: backgroundColor ?? AppColors.surface,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: iconColor ?? AppColors.primary),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTextStyles.titleLarge.copyWith(
              color: titleColor ?? AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: subtitleColor ?? AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          if (details.isNotEmpty) ...[
            const SizedBox(height: 16),
            ...details.map(_buildDetailRow),
          ],
        ],
      ),
    ),
  );

  Widget _buildDetailRow(final StatusDetail detail) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Icon(
          detail.icon,
          size: 16,
          color: detail.iconColor ?? AppColors.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            detail.text,
            style: AppTextStyles.bodySmall.copyWith(
              color: detail.textColor ?? AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

class StatusDetail {
  const StatusDetail({
    required this.icon,
    required this.text,
    this.iconColor,
    this.textColor,
  });

  final IconData icon;
  final String text;
  final Color? iconColor;
  final Color? textColor;
}
