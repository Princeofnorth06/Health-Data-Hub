import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';

class WellnessGauge extends StatefulWidget {
  const WellnessGauge({super.key, required this.score});

  /// Score from 0 to 100.
  final double score;

  @override
  State<WellnessGauge> createState() => _WellnessGaugeState();
}

class _WellnessGaugeState extends State<WellnessGauge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final targetProgress = (widget.score / 100).clamp(0.0, 1.0);
        final animatedProgress = targetProgress * _animation.value;
        final displayedScore = widget.score * _animation.value;

        return SizedBox(
          width: double.infinity,
          child: AspectRatio(
            aspectRatio: 1,
            child: CustomPaint(
              painter: WellnessGaugePainter(progress: animatedProgress),
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.4,
                  child: FittedBox(
                    child: Text(
                      '${displayedScore.round()}%',
                      style: AppTextStyles.gaugeScore,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class WellnessGaugePainter extends CustomPainter {
  WellnessGaugePainter({required this.progress});

  /// Filled portion of the gauge, from 0.0 to 1.0.
  final double progress;

  // 135° (bottom-left) sweeping 270° clockwise to bottom-right.
  static const double _startAngle = math.pi * 0.75;
  static const double _sweepAngle = math.pi * 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.shortestSide / 2;

    final labelRadius = outerRadius * 0.91;
    final tickOuterRadius = outerRadius * 0.80;
    final majorTickInnerRadius = outerRadius * 0.73;
    final minorTickInnerRadius = outerRadius * 0.765;
    final progressRadius = outerRadius * 0.64;
    final innerRingRadius = outerRadius * 0.54;
    final progressStrokeWidth = outerRadius * 0.048;

    _drawCenterGlow(canvas, center, outerRadius);
    _drawInnerRings(canvas, center, outerRadius, innerRingRadius);
    _drawTicks(
      canvas,
      center,
      tickOuterRadius,
      majorTickInnerRadius,
      minorTickInnerRadius,
    );
    _drawLabels(canvas, center, labelRadius, outerRadius);
    _drawTrack(canvas, center, progressRadius, progressStrokeWidth);
    _drawProgressArc(canvas, center, progressRadius, progressStrokeWidth);
    _drawHandle(canvas, center, progressRadius, progressStrokeWidth);
    _drawBottomMarker(canvas, center, innerRingRadius, outerRadius);
  }

  void _drawCenterGlow(Canvas canvas, Offset center, double outerRadius) {
    final rect = Rect.fromCircle(center: center, radius: outerRadius * 0.72);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primary.withValues(alpha: 0.20),
          AppColors.primary.withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(rect);
    canvas.drawCircle(center, outerRadius * 0.72, paint);
  }

  void _drawInnerRings(
    Canvas canvas,
    Offset center,
    double outerRadius,
    double innerRingRadius,
  ) {
    final mutedRingPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerRadius * 0.01
      ..color = AppColors.primary.withValues(alpha: 0.28);

    canvas.drawCircle(center, innerRingRadius, mutedRingPaint);

    final faintPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = AppColors.textPrimary.withValues(alpha: 0.08);

    canvas.drawCircle(center, outerRadius * 0.46, faintPaint);
    canvas.drawCircle(center, outerRadius * 0.40, faintPaint);
  }

  void _drawTicks(
    Canvas canvas,
    Offset center,
    double tickOuterRadius,
    double majorTickInnerRadius,
    double minorTickInnerRadius,
  ) {
    const tickCount = 50;

    final majorPaint = Paint()
      ..color = AppColors.textPrimary.withValues(alpha: 0.72)
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    final minorPaint = Paint()
      ..color = AppColors.textPrimary.withValues(alpha: 0.28)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i <= tickCount; i++) {
      final tickProgress = i / tickCount;
      final angle = _startAngle + _sweepAngle * tickProgress;
      final isMajor = i % 5 == 0;
      final innerRadius = isMajor ? majorTickInnerRadius : minorTickInnerRadius;

      final start = Offset(
        center.dx + innerRadius * math.cos(angle),
        center.dy + innerRadius * math.sin(angle),
      );
      final end = Offset(
        center.dx + tickOuterRadius * math.cos(angle),
        center.dy + tickOuterRadius * math.sin(angle),
      );

      canvas.drawLine(start, end, isMajor ? majorPaint : minorPaint);
    }
  }

  void _drawLabels(
    Canvas canvas,
    Offset center,
    double labelRadius,
    double outerRadius,
  ) {
    const labelCount = 10;
    final fontSize = outerRadius * 0.055;

    for (var i = 0; i <= labelCount; i++) {
      final labelProgress = i / labelCount;
      final angle = _startAngle + _sweepAngle * labelProgress;
      final percent = i * 10;

      final textPainter = TextPainter(
        text: TextSpan(
          text: '$percent%',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final labelCenter = Offset(
        center.dx + labelRadius * math.cos(angle),
        center.dy + labelRadius * math.sin(angle),
      );

      textPainter.paint(
        canvas,
        labelCenter - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
  }

  void _drawTrack(
    Canvas canvas,
    Offset center,
    double progressRadius,
    double strokeWidth,
  ) {
    final rect = Rect.fromCircle(center: center, radius: progressRadius);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF2A2A2A);
    canvas.drawArc(rect, _startAngle, _sweepAngle, false, paint);
  }

  void _drawProgressArc(
    Canvas canvas,
    Offset center,
    double progressRadius,
    double strokeWidth,
  ) {
    if (progress <= 0) {
      return;
    }

    final rect = Rect.fromCircle(center: center, radius: progressRadius);
    final sweep = _sweepAngle * progress;

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 1.8
      ..strokeCap = StrokeCap.round
      ..color = AppColors.primary.withValues(alpha: 0.28)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = AppColors.primary;

    canvas.drawArc(rect, _startAngle, sweep, false, glowPaint);
    canvas.drawArc(rect, _startAngle, sweep, false, arcPaint);
  }

  void _drawHandle(
    Canvas canvas,
    Offset center,
    double progressRadius,
    double strokeWidth,
  ) {
    final angle = _startAngle + _sweepAngle * progress;
    final handleCenter = Offset(
      center.dx + progressRadius * math.cos(angle),
      center.dy + progressRadius * math.sin(angle),
    );
    final handleRadius = strokeWidth * 0.72;

    final glowPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.45)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(handleCenter, handleRadius * 1.8, glowPaint);

    final fillPaint = Paint()..color = AppColors.primary;
    canvas.drawCircle(handleCenter, handleRadius, fillPaint);
  }

  void _drawBottomMarker(
    Canvas canvas,
    Offset center,
    double innerRingRadius,
    double outerRadius,
  ) {
    final markerY = center.dy + innerRingRadius;
    final markerWidth = outerRadius * 0.07;

    final paint = Paint()
      ..color = AppColors.accentCyan
      ..strokeWidth = outerRadius * 0.014
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    canvas.drawLine(
      Offset(center.dx - markerWidth / 2, markerY),
      Offset(center.dx + markerWidth / 2, markerY),
      paint,
    );
  }

  @override
  bool shouldRepaint(WellnessGaugePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
