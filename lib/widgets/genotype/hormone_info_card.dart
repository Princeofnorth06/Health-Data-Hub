import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/data/models/hormone_data.dart';

class HormoneInfoCard extends StatelessWidget {
  const HormoneInfoCard({super.key, required this.hormone});

  final HormoneData hormone;

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hormone.fullTitle, style: AppTextStyles.heading),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              text: 'Genotype Score: ',
              style: AppTextStyles.body,
              children: [
                TextSpan(
                  text: '${hormone.level.round()}%',
                  style: AppTextStyles.scoreValue.copyWith(
                    color: AppColors.scoreHighlight,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(hormone.interpretation!, style: AppTextStyles.body),
        ],
      ),
    );
  }
}

class HormoneAboutSection extends StatelessWidget {
  const HormoneAboutSection({super.key, required this.hormone});

  final HormoneData hormone;

  @override
  Widget build(BuildContext context) {
    if (!hormone.hasAbout) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ABOUT ${hormone.fullTitle}',
          style: AppTextStyles.heading,
        ),
        const SizedBox(height: 8),
        Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.accentCyan.withValues(alpha: 0.8),
                Colors.transparent,
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (hormone.about != null)
          Text(hormone.about!, style: AppTextStyles.body),
        if (hormone.aboutVariations.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'If you’d like, here are a few style variations depending on the tone:',
            style: AppTextStyles.body,
          ),
          const SizedBox(height: 12),
          for (final variation in hormone.aboutVariations) ...[
            Text(variation.label, style: AppTextStyles.aboutLabel),
            const SizedBox(height: 4),
            Text(variation.text, style: AppTextStyles.body),
            const SizedBox(height: 10),
          ],
        ],
      ],
    );
  }
}
