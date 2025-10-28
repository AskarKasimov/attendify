import 'package:attendify/shared/ui_kit/theme/app_colors.dart';
import 'package:attendify/shared/ui_kit/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class MiniActionCard extends StatelessWidget {
  const MiniActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) => Card(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                title,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
