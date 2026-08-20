import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_data_hub/app/routes/app_routes.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/data/models/genetic_trait.dart';

class OrganwiseScoreSection extends StatelessWidget {
  const OrganwiseScoreSection({super.key, required this.gene});

  final GeneticTrait gene;

  static const Color _strength = Color(0xFF7CFF6B);
  static const Color _weakness = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    if (!gene.hasOrganwise) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${gene.name} Organwise Score',
          style: AppTextStyles.heading,
        ),
        if (gene.strengths.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'Strengths :',
            style: AppTextStyles.bodyLarge.copyWith(color: _strength),
          ),
          const SizedBox(height: 10),
          _OrganChipWrap(
            items: gene.strengths,
            accent: _strength,
          ),
        ],
        if (gene.weaknesses.isNotEmpty) ...[
          const SizedBox(height: 18),
          Text(
            'Weakness :',
            style: AppTextStyles.bodyLarge.copyWith(color: _weakness),
          ),
          const SizedBox(height: 10),
          _OrganChipWrap(
            items: gene.weaknesses,
            accent: _weakness,
          ),
        ],
      ],
    );
  }
}

class _OrganChipWrap extends StatelessWidget {
  const _OrganChipWrap({
    required this.items,
    required this.accent,
  });

  final List<OrganScore> items;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - 16) / 3;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final item in items)
              SizedBox(
                width: width,
                child: _OrganScoreChip(item: item, accent: accent),
              ),
          ],
        );
      },
    );
  }
}

class _OrganScoreChip extends StatelessWidget {
  const _OrganScoreChip({
    required this.item,
    required this.accent,
  });

  final OrganScore item;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.id == 'heart'
          ? () => Get.toNamed(AppRoutes.heartScore)
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.85)),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.28),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              '${item.value.toStringAsFixed(2)} %',
              style: AppTextStyles.scoreValue.copyWith(color: accent),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: AppTextStyles.chipLabel,
            ),
          ],
        ),
      ),
    );
  }
}
