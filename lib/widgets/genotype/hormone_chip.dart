import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';

class HormoneChip extends StatelessWidget {
  const HormoneChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected
        ? AppColors.accentCyan
        : AppColors.textPrimary.withValues(alpha: 0.55);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 14 : 10,
          vertical: selected ? 8 : 6,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.surface.withValues(alpha: 0.92)
              : AppColors.background.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.accentCyan.withValues(alpha: 0.28),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: AppTextStyles.chipLabel.copyWith(
            color: AppColors.textPrimary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
