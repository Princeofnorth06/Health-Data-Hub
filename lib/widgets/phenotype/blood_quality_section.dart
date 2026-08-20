import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/core/constants/app_assets.dart';
import 'package:health_data_hub/data/models/blood_quality.dart';
import 'package:health_data_hub/widgets/gauges/provided_score_gauge.dart';
import 'package:health_data_hub/widgets/phenotype/blood_health_overview.dart';
import 'package:health_data_hub/widgets/phenotype/blood_recommendations.dart';
import 'package:health_data_hub/widgets/wellness/range_legend_grid.dart';

class BloodQualitySection extends StatelessWidget {
  const BloodQualitySection({
    super.key,
    required this.gaugeSize,
    this.data = BloodQuality.current,
  });

  final double gaugeSize;
  final BloodQuality data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(data.title, style: AppTextStyles.displayMedium),
        ),
        const SizedBox(height: 8),
        Center(
          child: SizedBox(
            width: gaugeSize,
            height: gaugeSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                IgnorePointer(
                  child: Container(
                    width: gaugeSize * 0.72,
                    height: gaugeSize * 0.72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF48AF3C).withValues(
                            alpha: 0.22,
                          ),
                          blurRadius: 48,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                ProvidedScoreGauge(
                  asset: AppAssets.gaugeGreen,
                  score: data.score,
                  size: gaugeSize,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        RangeLegendGrid(ranges: data.ranges),
        const SizedBox(height: 24),
        BloodHealthOverview(data: data),
        const SizedBox(height: 24),
        BloodRecommendations(data: data),
      ],
    );
  }
}
