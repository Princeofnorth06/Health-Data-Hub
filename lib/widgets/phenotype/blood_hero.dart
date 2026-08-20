import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/core/constants/app_assets.dart';
import 'package:health_data_hub/data/models/blood_metrics.dart';

class BloodHero extends StatelessWidget {
  const BloodHero({
    super.key,
    required this.height,
    required this.metrics,
  });

  final double height;
  final BloodMetrics metrics;

  static const _rbcAlign = Alignment(-0.95, -0.62);
  static const _spo2Align = Alignment(0.95, -0.42);
  static const _wbcAlign = Alignment(-0.2, 0.72);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IgnorePointer(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.bottomCenter,
                    radius: 0.85,
                    colors: [
                      AppColors.accentCyan.withValues(alpha: 0.28),
                      AppColors.primary.withValues(alpha: 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: _HolographicPlatform(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 36, left: 24, right: 24),
            child: Image.asset(
              AppAssets.redBloodCells,
              fit: BoxFit.contain,
            ),
          ),
          IgnorePointer(
            child: CustomPaint(
              size: Size.infinite,
              painter: const _CalloutConnectorPainter(
                alignments: [_rbcAlign, _spo2Align, _wbcAlign],
              ),
            ),
          ),
          Align(
            alignment: _rbcAlign,
            child: _Callout(
              title: metrics.rbcLabel,
              value: metrics.rbcValue,
            ),
          ),
          Align(
            alignment: _spo2Align,
            child: _Callout(
              title: metrics.spo2Label,
              value: metrics.spo2Value,
            ),
          ),
          Align(
            alignment: _wbcAlign,
            child: _Callout(
              title: metrics.wbcLabel,
              value: metrics.wbcValue,
            ),
          ),
        ],
      ),
    );
  }
}

class _CalloutConnectorPainter extends CustomPainter {
  const _CalloutConnectorPainter({required this.alignments});

  final List<Alignment> alignments;

  @override
  void paint(Canvas canvas, Size size) {
    final origin = Offset(size.width / 2, size.height * 0.42);
    final paint = Paint()
      ..color = AppColors.textPrimary.withValues(alpha: 0.55)
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke;

    for (final alignment in alignments) {
      final target = Offset(
        (alignment.x + 1) / 2 * size.width,
        (alignment.y + 1) / 2 * size.height,
      );
      canvas.drawLine(origin, target, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CalloutConnectorPainter oldDelegate) {
    return false;
  }
}

class _Callout extends StatelessWidget {
  const _Callout({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 168),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xE00A1220),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.textPrimary.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentCyan.withValues(alpha: 0.16),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.chipLabel.copyWith(fontSize: 9),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.chipLabel.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _HolographicPlatform extends StatelessWidget {
  const _HolographicPlatform();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 54,
      width: 220,
      child: CustomPaint(
        painter: _PlatformPainter(),
      ),
    );
  }
}

class _PlatformPainter extends CustomPainter {
  const _PlatformPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.45);

    for (var i = 0; i < 4; i++) {
      final width = size.width * (1 - i * 0.16);
      final height = size.height * (0.55 - i * 0.08);
      final rect = Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      );
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = i == 0 ? 2.2 : 1.1
        ..color = AppColors.accentCyan.withValues(alpha: 0.55 - i * 0.1);
      canvas.drawOval(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
