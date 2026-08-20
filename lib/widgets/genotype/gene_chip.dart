import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';

class GeneChip extends StatelessWidget {
  const GeneChip({
    super.key,
    required this.title,
    required this.subtitle,
    this.selected = false,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback? onTap;

  static const Color _selectedRim = Color(0xFF7CFF6B);
  static const Color _fill = Color(0xF00A1220);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        constraints: const BoxConstraints(maxWidth: 168),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: _fill,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? _selectedRim
                : AppColors.textPrimary.withValues(alpha: 0.45),
            width: selected ? 1.4 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: _selectedRim.withValues(alpha: 0.45),
                    blurRadius: 16,
                  ),
                  BoxShadow(
                    color: _selectedRim.withValues(alpha: 0.18),
                    blurRadius: 24,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.accentCyan.withValues(alpha: 0.12),
                    blurRadius: 10,
                  ),
                ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.chipLabel.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
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
        ),
      ),
    );
  }
}

class Spo2Chip extends StatelessWidget {
  const Spo2Chip({super.key, required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 168),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xF00A1220),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.12),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Blood Oxygen Saturation (SpO2)',
            style: AppTextStyles.chipLabel.copyWith(fontSize: 9),
          ),
          const SizedBox(height: 4),
          Text(
            '${value.round()}%',
            style: AppTextStyles.heading.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
