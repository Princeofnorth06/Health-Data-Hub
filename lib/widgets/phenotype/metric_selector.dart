import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/controllers/genotype_controller.dart';
import 'package:health_data_hub/core/constants/app_assets.dart';
import 'package:health_data_hub/data/models/blood_metrics.dart';

class MetricSelector extends StatelessWidget {
  const MetricSelector({super.key, required this.controller});

  final GenotypeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final open = controller.isMetricMenuOpen.value;
      final selected = controller.selectedPhenotypeMetric.value;
      final title = PhenotypeMetric.catalog
          .firstWhere(
            (metric) => metric.id == selected,
            orElse: () => PhenotypeMetric.catalog[1],
          )
          .title;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: controller.toggleMetricMenu,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: AppTextStyles.displayMedium),
                const SizedBox(width: 8),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.accentCyan.withValues(alpha: 0.7),
                    ),
                  ),
                  child: Icon(
                    open
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.textPrimary,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          if (open) ...[
            const SizedBox(height: 10),
            _MetricSelectorGraphic(
              onSelect: controller.selectPhenotypeMetric,
            ),
          ],
        ],
      );
    });
  }
}

class _MetricSelectorGraphic extends StatelessWidget {
  const _MetricSelectorGraphic({required this.onSelect});

  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 196,
      child: AspectRatio(
        aspectRatio: 0.72,
        child: Stack(
          children: [
            Image.asset(
              AppAssets.metricSelector,
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
            ),
            Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onSelect(PhenotypeMetric.organ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onSelect(PhenotypeMetric.blood),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onSelect(PhenotypeMetric.hormone),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
