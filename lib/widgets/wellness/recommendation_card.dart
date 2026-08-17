import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.title,
    required this.items,
    this.genotypeScore,
    this.emphasized = false,
  });

  final String title;
  final List<String> items;
  final double? genotypeScore;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.heading),
        if (!emphasized) ...[
          const SizedBox(height: 8),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.textSecondary.withValues(alpha: 0.55),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
        if (genotypeScore != null) ...[
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              text: 'Overall Genotype Score: ',
              style: AppTextStyles.body,
              children: [
                TextSpan(
                  text: '${genotypeScore!.toStringAsFixed(2)}%',
                  style: AppTextStyles.scoreValue.copyWith(
                    color: AppColors.scoreHighlight,
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 12),
        for (final item in items) _BulletLine(text: item),
      ],
    );

    if (!emphasized) {
      return content;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accentCyan.withValues(alpha: 0.85)),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentCyan.withValues(alpha: 0.22),
            blurRadius: 18,
          ),
        ],
      ),
      child: content,
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 7),
            decoration: const BoxDecoration(
              color: AppColors.textSecondary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyles.body)),
        ],
      ),
    );
  }
}
