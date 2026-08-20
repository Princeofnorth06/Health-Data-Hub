import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';

class HormoneChip extends StatelessWidget {
  const HormoneChip({
    super.key,
    required this.label,
    this.subtitle,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final String? subtitle;
  final bool selected;
  final VoidCallback? onTap;

  static const Color _selectedFill = Color(0xFF060C1D);

  @override
  Widget build(BuildContext context) {
    final borderColor = selected
        ? AppColors.accentCyan
        : AppColors.textPrimary.withValues(alpha: 0.45);

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
              ? _selectedFill.withValues(alpha: 0.94)
              : AppColors.background.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.accentCyan.withValues(alpha: 0.35),
                    blurRadius: 14,
                  ),
                  BoxShadow(
                    color: AppColors.accentCyan.withValues(alpha: 0.18),
                    blurRadius: 22,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.chipLabel.copyWith(
                color: AppColors.textPrimary,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                '($subtitle)',
                style: AppTextStyles.chipLabel.copyWith(
                  fontSize: 8,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
