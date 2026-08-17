import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/data/models/wellness_data.dart';

class RangeItem extends StatelessWidget {
  const RangeItem({super.key, required this.range});

  final WellnessRange range;

  Color get _color {
    switch (range.name) {
      case 'High':
        return AppColors.rangeHigh;
      case 'Moderate':
        return AppColors.rangeModerate;
      default:
        return AppColors.rangeLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 16,
          height: 16,
          margin: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: _color.withValues(alpha: 0.55),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${range.name} (${range.label})',
                style: AppTextStyles.rangeLabel,
              ),
              const SizedBox(height: 4),
              Text(range.description, style: AppTextStyles.caption),
            ],
          ),
        ),
      ],
    );
  }
}
