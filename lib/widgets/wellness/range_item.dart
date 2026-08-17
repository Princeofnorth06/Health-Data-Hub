import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';

class RangeItem extends StatelessWidget {
  const RangeItem({super.key, this.label = 'Range', this.value = '—'});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.body),
        Text(value, style: AppTextStyles.subtitle),
      ],
    );
  }
}
