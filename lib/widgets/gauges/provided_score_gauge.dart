import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';

/// Circular dial from a provided decorative PNG, with a live score overlay.
class ProvidedScoreGauge extends StatelessWidget {
  const ProvidedScoreGauge({
    super.key,
    required this.asset,
    required this.score,
    this.size = 280,
  });

  final String asset;
  final double score;
  final double size;

  static const Color _centerFill = Color(0xFF0D0E17);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
          Container(
            width: size * 0.29,
            height: size * 0.29,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: _centerFill,
            ),
          ),
          Text(
            '${score.round()}%',
            style: AppTextStyles.gaugeScore,
          ),
        ],
      ),
    );
  }
}
