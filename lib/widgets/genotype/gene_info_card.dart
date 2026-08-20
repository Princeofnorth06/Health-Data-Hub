import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/data/models/genetic_trait.dart';

class GeneInfoCard extends StatelessWidget {
  const GeneInfoCard({super.key, required this.gene});

  final GeneticTrait gene;

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
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF000000),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _rim, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(gene.fullTitle, style: AppTextStyles.heading),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: 'Genotype Score: ',
                style: AppTextStyles.body,
                children: [
                  TextSpan(
                    text: '${gene.score.round()}%',
                    style: AppTextStyles.scoreValue.copyWith(
                      color: const Color(0xFFFFC800),
                    ),
                  ),
                ],
              ),
            ),
            if (gene.interpretation != null) ...[
              const SizedBox(height: 12),
              Text(gene.interpretation!, style: AppTextStyles.body),
            ],
          ],
        ),
      ),
    );
  }
}

class GeneAboutSection extends StatelessWidget {
  const GeneAboutSection({super.key, required this.gene});

  final GeneticTrait gene;

  @override
  Widget build(BuildContext context) {
    if (gene.about == null || gene.about!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ABOUT ${gene.name} ${gene.genotype}',
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
        Text(gene.about!, style: AppTextStyles.body),
      ],
    );
  }
}
