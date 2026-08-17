import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';

class WellnessGauge extends StatefulWidget {
  const WellnessGauge({super.key, required this.score});

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
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
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
        return SizedBox(
          width: double.infinity,
          child: AspectRatio(
            aspectRatio: 1,
            child: CustomPaint(
              size: Size.infinite,
              painter: WellnessGaugePainter(
                score: widget.score,
                animationValue: _animation.value,
              ),
            ),
          ),
        );
      },
    );
  }
}

class WellnessGaugePainter extends CustomPainter {
  WellnessGaugePainter({
    required this.score,
    required this.animationValue,
  });

  final double score;
  final double animationValue;

  // 7:30 → 12 o'clock → 4:30
  static const double _startAngle = 3 * math.pi / 4;
  static const double _sweepAngle = 3 * math.pi / 2;

  static const Color _neonGreen = Color(0xFF9EFF6C);
  static const Color _tickTeal = Color(0xFF5EE0E0);
  static const Color _labelGray = Color(0xFFB8B8B8);

  static const double _centerScoreFontScale = 0.20;
  static const double _labelFontScale = 0.086;
  static const double _labelOpacity = 0.58;
  static const double _labelRadiusScale = 0.875;
  static const double _tickOuterScale = 0.80;
  static const double _majorTickInnerScale = 0.735;
  static const double _minorTickInnerScale = 0.76;
  static const double _cyanRingScale = 0.70;
  static const double _arcRadiusScale = 0.64;
  static const double _innerRingScale = 0.52;
  static const double _innerTickScale = 0.455;

  double get _progress {
    return (score / 100).clamp(0.0, 1.0) * animationValue;
  }

  double get _progressAngle => _sweepAngle * _progress;

  double get _displayedScore => score * animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    _drawBackgroundGlow(canvas, center, radius);
    _drawInnerRing(canvas, center, radius);
    _drawOuterCyanRing(canvas, center, radius);
    _drawOuterTicks(canvas, center, radius);
    _drawScaleLabels(canvas, center, radius);
    _drawMainArc(canvas, center, radius);
    _drawInnerTicks(canvas, center, radius);
    _drawScoreMarker(canvas, center, radius);
    _drawBottomHighlight(canvas, center, radius);
    _drawCenterScore(canvas, center, radius);
  }

  Offset _point(Offset center, double radius, double angle) {
    return Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );
  }

  void _drawBackgroundGlow(Canvas canvas, Offset center, double radius) {
    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          _neonGreen.withValues(alpha: 0.12),
          _neonGreen.withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(rect);

    canvas.drawCircle(center, radius, paint);
  }

  void _drawOuterTicks(Canvas canvas, Offset center, double radius) {
    const tickCount = 50;
    final tickOuterRadius = radius * _tickOuterScale;
    final majorInnerRadius = radius * _majorTickInnerScale;
    final minorInnerRadius = radius * _minorTickInnerScale;

    final majorPaint = Paint()
      ..color = _tickTeal.withValues(alpha: 0.78)
      ..strokeWidth = radius * 0.008
      ..strokeCap = StrokeCap.round;

    final minorPaint = Paint()
      ..color = _tickTeal.withValues(alpha: 0.22)
      ..strokeWidth = radius * 0.004
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i <= tickCount; i++) {
      final tickProgress = i / tickCount;
      final angle = _startAngle + _sweepAngle * tickProgress;
      final isMajor = i % 5 == 0;
      final innerRadius = isMajor ? majorInnerRadius : minorInnerRadius;

      canvas.drawLine(
        _point(center, innerRadius, angle),
        _point(center, tickOuterRadius, angle),
        isMajor ? majorPaint : minorPaint,
      );
    }
  }

  void _drawScaleLabels(Canvas canvas, Offset center, double radius) {
    const labelCount = 10;
    final labelRadius = radius * _labelRadiusScale;
    final fontSize = radius * _labelFontScale;

    for (var i = 0; i <= labelCount; i++) {
      final t = i / labelCount;
      final angle = _startAngle + _sweepAngle * t;
      final percent = i * 10;

      final textPainter = TextPainter(
        text: TextSpan(
          text: '$percent%',
          style: AppTextStyles.gaugeLabel.copyWith(
            color: _labelGray.withValues(alpha: _labelOpacity),
            fontSize: fontSize,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final labelCenter = _point(center, labelRadius, angle);
      textPainter.paint(
        canvas,
        labelCenter - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
  }

  void _drawOuterCyanRing(Canvas canvas, Offset center, double radius) {
    final ringRadius = radius * _cyanRingScale;

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.03
      ..color = AppColors.accentCyan.withValues(alpha: 0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.012
      ..color = AppColors.accentCyan.withValues(alpha: 0.32);

    canvas.drawCircle(center, ringRadius, glowPaint);
    canvas.drawCircle(center, ringRadius, ringPaint);
  }

  void _drawMainArc(Canvas canvas, Offset center, double radius) {
    final arcRadius = radius * _arcRadiusScale;
    final strokeWidth = radius * 0.048;
    final rect = Rect.fromCircle(center: center, radius: arcRadius);

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF1A1A1A);

    canvas.drawArc(rect, _startAngle, _sweepAngle, false, trackPaint);

    if (_progress <= 0) {
      return;
    }

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 1.45
      ..strokeCap = StrokeCap.round
      ..color = _neonGreen.withValues(alpha: 0.20)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = _neonGreen;

    canvas.drawArc(rect, _startAngle, _progressAngle, false, glowPaint);
    canvas.drawArc(rect, _startAngle, _progressAngle, false, arcPaint);
  }

  void _drawScoreMarker(Canvas canvas, Offset center, double radius) {
    final arcRadius = radius * _arcRadiusScale;
    final angle = _startAngle + _progressAngle;
    final markerCenter = _point(center, arcRadius, angle);
    final markerRadius = radius * 0.030;

    final glowPaint = Paint()
      ..color = _neonGreen.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(markerCenter, markerRadius * 1.8, glowPaint);

    final fillPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        colors: [
          Colors.white.withValues(alpha: 0.85),
          _neonGreen,
          const Color(0xFF1B5E20),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: markerCenter, radius: markerRadius));

    canvas.drawCircle(markerCenter, markerRadius, fillPaint);
  }

  void _drawInnerRing(Canvas canvas, Offset center, double radius) {
    final innerRadius = radius * _innerRingScale;

    final fillPaint = Paint()
      ..shader = RadialGradient(
        colors: const [
          Color(0xFF050805),
          Color(0xFF0C1F0C),
          Color(0xFF1B4D1B),
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: innerRadius));
    canvas.drawCircle(center, innerRadius, fillPaint);

    final edgeGlow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.016
      ..color = _neonGreen.withValues(alpha: 0.26)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawCircle(center, innerRadius, edgeGlow);

    final edgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.007
      ..color = _neonGreen.withValues(alpha: 0.48);
    canvas.drawCircle(center, innerRadius, edgePaint);
  }

  void _drawInnerTicks(Canvas canvas, Offset center, double radius) {
    const totalDashes = 22;
    final tickRadius = radius * _innerTickScale;
    final tickLength = radius * 0.032;

    final dimPaint = Paint()
      ..color = _neonGreen.withValues(alpha: 0.16)
      ..strokeWidth = radius * 0.008
      ..strokeCap = StrokeCap.round;

    final litPaint = Paint()
      ..color = _neonGreen
      ..strokeWidth = radius * 0.01
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i <= totalDashes; i++) {
      final dashProgress = i / totalDashes;
      final angle = _startAngle + _sweepAngle * dashProgress;
      final isLit = _progress >= dashProgress;

      canvas.drawLine(
        _point(center, tickRadius - tickLength / 2, angle),
        _point(center, tickRadius + tickLength / 2, angle),
        isLit ? litPaint : dimPaint,
      );
    }
  }

  void _drawBottomHighlight(Canvas canvas, Offset center, double radius) {
    final markerY = center.dy + radius * _innerRingScale;
    final markerWidth = radius * 0.07;

    final glowPaint = Paint()
      ..color = AppColors.accentCyan.withValues(alpha: 0.28)
      ..strokeWidth = radius * 0.016
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final paint = Paint()
      ..color = AppColors.accentCyan.withValues(alpha: 0.75)
      ..strokeWidth = radius * 0.009
      ..strokeCap = StrokeCap.round;

    final start = Offset(center.dx - markerWidth / 2, markerY);
    final end = Offset(center.dx + markerWidth / 2, markerY);
    canvas.drawLine(start, end, glowPaint);
    canvas.drawLine(start, end, paint);
  }

  void _drawCenterScore(Canvas canvas, Offset center, double radius) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${_displayedScore.round()}%',
        style: AppTextStyles.gaugeScore.copyWith(
          fontSize: radius * _centerScoreFontScale,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(WellnessGaugePainter oldDelegate) {
    return oldDelegate.score != score ||
        oldDelegate.animationValue != animationValue;
  }
}
