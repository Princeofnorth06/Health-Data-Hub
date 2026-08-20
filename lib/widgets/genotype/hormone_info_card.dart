import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/data/models/hormone_data.dart';

class HormoneInfoCard extends StatelessWidget {
  const HormoneInfoCard({super.key, required this.hormone});

  final HormoneData hormone;

  static const Color _glow = Color(0xFF12708B);
  static const Color _rim = Color(0xFF1B8CA8);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _glow.withValues(alpha: 0.7),
            blurRadius: 18,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: _glow.withValues(alpha: 0.4),
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
          border: Border.all(color: _rim, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: _glow.withValues(alpha: 0.55),
              blurRadius: 14,
              spreadRadius: 0.5,
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
                      color: const Color(0xFFFFC800),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(hormone.interpretation ?? '', style: AppTextStyles.body),
          ],
        ),
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
          height: 1.5,
          decoration: const BoxDecoration(
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
