import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/data/models/blood_quality.dart';

class BloodRecommendations extends StatelessWidget {
  const BloodRecommendations({super.key, required this.data});

  final BloodQuality data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Our Recommendations', style: AppTextStyles.heading),
        const SizedBox(height: 12),
        const Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: 0.38,
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
        const SizedBox(height: 16),
        for (final group in data.recommendationGroups) ...[
          Text(group.title, style: AppTextStyles.aboutLabel),
          const SizedBox(height: 8),
          for (final item in group.items) _RecommendationBullet(item: item),
          const SizedBox(height: 10),
        ],
        Text.rich(
          TextSpan(
            text: 'Tip: ',
            style: AppTextStyles.aboutLabel.copyWith(fontSize: 13),
            children: [
              TextSpan(text: data.tip, style: AppTextStyles.body),
            ],
          ),
        ),
      ],
    );
  }
}

class _RecommendationBullet extends StatelessWidget {
  const _RecommendationBullet({required this.item});

  final BloodRecommendationItem item;

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
          Expanded(
            child: Text.rich(
              TextSpan(
                text: '${item.label}: ',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: item.body,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
