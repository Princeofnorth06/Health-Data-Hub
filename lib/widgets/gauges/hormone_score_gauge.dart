import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';

class HormoneScoreGauge extends StatefulWidget {
  const HormoneScoreGauge({
    super.key,
    required this.score,
    this.maxScale = 80,
  });

  final double score;
  final double maxScale;

  @override
  State<HormoneScoreGauge> createState() => _HormoneScoreGaugeState();
}

class _HormoneScoreGaugeState extends State<HormoneScoreGauge>
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
  void didUpdateWidget(HormoneScoreGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score) {
      _controller.forward(from: 0);
    }
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
        return AspectRatio(
          aspectRatio: 1,
          child: CustomPaint(
            painter: HormoneScoreGaugePainter(
              score: widget.score,
              maxScale: widget.maxScale,
              animationValue: _animation.value,
            ),
          ),
        );
      },
    );
  }
}

class HormoneScoreGaugePainter extends CustomPainter {
  HormoneScoreGaugePainter({
    required this.score,
    required this.maxScale,
    required this.animationValue,
  });

  final double score;
  final double maxScale;
  final double animationValue;

  static const double _startAngle = 3 * math.pi / 4;
  static const double _sweepAngle = 3 * math.pi / 2;
  static const Color _neonGreen = Color(0xFF9EFF6C);

  double get _progress {
    if (maxScale <= 0) {
      return 0;
    }
    return (score / maxScale).clamp(0.0, 1.0) * animationValue;
  }

  double get _progressAngle => _sweepAngle * _progress;

  double get _displayedScore => score * animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    _drawGlow(canvas, center, radius);
    _drawInnerCore(canvas, center, radius);
    _drawOuterRing(canvas, center, radius);
    _drawScaleLabels(canvas, center, radius);
    _drawSegmentedArc(canvas, center, radius);
    _drawNeedle(canvas, center, radius);
    _drawTopMarker(canvas, center, radius);
    _drawCenterScore(canvas, center, radius);
  }

  Offset _point(Offset center, double radius, double angle) {
    return Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );
  }

  void _drawGlow(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          _neonGreen.withValues(alpha: 0.16),
          _neonGreen.withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  void _drawInnerCore(Canvas canvas, Offset center, double radius) {
    final coreRadius = radius * 0.42;

    final fill = Paint()
      ..shader = RadialGradient(
        colors: const [
          Color(0xFF050805),
          Color(0xFF0C1F0C),
          Color(0xFF163616),
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: coreRadius));
    canvas.drawCircle(center, coreRadius, fill);

    final edge = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.008
      ..color = _neonGreen.withValues(alpha: 0.45);
    canvas.drawCircle(center, coreRadius, edge);
  }

  void _drawOuterRing(Canvas canvas, Offset center, double radius) {
    final ringRadius = radius * 0.78;

    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.028
      ..color = _neonGreen.withValues(alpha: 0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.01
      ..color = _neonGreen.withValues(alpha: 0.35);

    canvas.drawCircle(center, ringRadius, glow);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: ringRadius),
      _startAngle,
      _sweepAngle,
      false,
      ring,
    );
  }

  void _drawScaleLabels(Canvas canvas, Offset center, double radius) {
    const steps = 4;
    final labelRadius = radius * 0.90;
    final fontSize = radius * 0.072;

    for (var i = 0; i <= steps; i++) {
      final t = i / steps;
      final value = (maxScale * t).round();
      final angle = _startAngle + _sweepAngle * t;
      final isTop = i == steps / 2;

      final painter = TextPainter(
        text: TextSpan(
          text: '$value',
          style: AppTextStyles.gaugeLabel.copyWith(
            color: isTop
                ? AppColors.accentCyan
                : const Color(0xFFB8B8B8).withValues(alpha: 0.8),
            fontSize: fontSize,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final labelCenter = _point(center, labelRadius, angle);
      painter.paint(
        canvas,
        labelCenter - Offset(painter.width / 2, painter.height / 2),
      );
    }
  }

  void _drawSegmentedArc(Canvas canvas, Offset center, double radius) {
    const segmentCount = 22;
    final tickRadius = radius * 0.58;
    final tickLength = radius * 0.055;

    final dimPaint = Paint()
      ..color = _neonGreen.withValues(alpha: 0.16)
      ..strokeWidth = radius * 0.018
      ..strokeCap = StrokeCap.round;

    final litPaint = Paint()
      ..color = _neonGreen
      ..strokeWidth = radius * 0.02
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i <= segmentCount; i++) {
      final t = i / segmentCount;
      final angle = _startAngle + _sweepAngle * t;
      final lit = _progress >= t;

      canvas.drawLine(
        _point(center, tickRadius - tickLength / 2, angle),
        _point(center, tickRadius + tickLength / 2, angle),
        lit ? litPaint : dimPaint,
      );
    }
  }

  void _drawNeedle(Canvas canvas, Offset center, double radius) {
    final angle = _startAngle + _progressAngle;
    final inner = radius * 0.18;
    final outer = radius * 0.74;

    final glow = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..strokeWidth = radius * 0.012
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final needle = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..strokeWidth = radius * 0.006
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      _point(center, inner, angle),
      _point(center, outer, angle),
      glow,
    );
    canvas.drawLine(
      _point(center, inner, angle),
      _point(center, outer, angle),
      needle,
    );

    final tip = _point(center, outer, angle);
    canvas.drawCircle(
      tip,
      radius * 0.016,
      Paint()..color = _neonGreen,
    );
  }

  void _drawTopMarker(Canvas canvas, Offset center, double radius) {
    final path = Path()
      ..moveTo(center.dx, center.dy - radius * 0.82)
      ..lineTo(center.dx - radius * 0.028, center.dy - radius * 0.74)
      ..lineTo(center.dx + radius * 0.028, center.dy - radius * 0.74)
      ..close();

    canvas.drawPath(path, Paint()..color = _neonGreen);
  }

  void _drawCenterScore(Canvas canvas, Offset center, double radius) {
    final painter = TextPainter(
      text: TextSpan(
        text: '${_displayedScore.round()}%',
        style: AppTextStyles.gaugeScore.copyWith(
          fontSize: radius * 0.22,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    painter.paint(
      canvas,
      center - Offset(painter.width / 2, painter.height / 2),
    );
  }

  @override
  bool shouldRepaint(HormoneScoreGaugePainter oldDelegate) {
    return oldDelegate.score != score ||
        oldDelegate.maxScale != maxScale ||
        oldDelegate.animationValue != animationValue;
  }
}
