import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';

class WellnessGauge extends StatelessWidget {
  const WellnessGauge({super.key, required this.score});

  final double score;

  @override
  Widget build(BuildContext context) {
    final progress = (score / 100).clamp(0.0, 1.0);

    // Placeholder until the CustomPainter gauge is implemented.
    return Center(
      child: SizedBox(
        width: 220,
        height: 220,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.28),
                    blurRadius: 40,
                    spreadRadius: 6,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 188,
              height: 188,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 10,
                color: AppColors.primary,
                backgroundColor: const Color(0xFF2A2A2A),
              ),
            ),
            Text('${score.round()}%', style: AppTextStyles.gaugeScore),
          ],
        ),
      ),
    );
  }
}
