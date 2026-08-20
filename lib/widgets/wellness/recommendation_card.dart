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
          const SizedBox(height: 14),
          const Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.62,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF00C5FB),
                      Color(0x0000C5FB),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x8000C5FB),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: SizedBox(width: double.infinity, height: 1.5),
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
                    color: emphasized
                        ? const Color(0xFFFFC800)
                        : AppColors.scoreHighlight,
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

    const glow = Color(0xFF12708B);
    const rim = Color(0xFF1B8CA8);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: glow.withValues(alpha: 0.7),
            blurRadius: 18,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: glow.withValues(alpha: 0.4),
            blurRadius: 32,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: const Color(0xFF00C8FF).withValues(alpha: 0.18),
            blurRadius: 24,
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF000000),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: rim, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: glow.withValues(alpha: 0.55),
              blurRadius: 14,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: content,
      ),
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
