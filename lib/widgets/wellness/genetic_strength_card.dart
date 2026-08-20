import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/data/models/hormone_data.dart';

class GeneticStrengthCard extends StatelessWidget {
  const GeneticStrengthCard({super.key, required this.items});

  final List<HormoneData> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Genetic Strengths', style: AppTextStyles.heading),
              ),
              Icon(
                Icons.more_vert,
                color: AppColors.textPrimary.withValues(alpha: 0.8),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Highlighted areas where your genotype shows optimal performance',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text('Trait/Hormone', style: AppTextStyles.caption),
              ),
              Text('Score', style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < items.length; i++) ...[
            _StrengthRow(item: items[i]),
            if (i != items.length - 1)
              Divider(
                height: 20,
                color: AppColors.cardBorder.withValues(alpha: 0.9),
              ),
          ],
        ],
      ),
    );
  }
}

class _StrengthRow extends StatelessWidget {
  const _StrengthRow({required this.item});

  final HormoneData item;

  @override
  Widget build(BuildContext context) {
    final progress = (item.level / 100).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: AppTextStyles.subtitle),
                  if (item.description != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.description!,
                      style: AppTextStyles.strengthDetail,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text('${item.level.round()}%', style: AppTextStyles.scoreValue),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            color: AppColors.progress,
            backgroundColor: AppColors.cardBorder,
          ),
        ),
      ],
    );
  }
}
