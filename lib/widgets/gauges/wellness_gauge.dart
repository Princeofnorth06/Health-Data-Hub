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
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
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
  WellnessGaugePainter({required this.score, required this.animationValue});

  final double score;
  final double animationValue;

  // 7:30 → 12 o'clock → 4:30
  static const double _startAngle = 3 * math.pi / 4;
  static const double _sweepAngle = 3 * math.pi / 2;

  static const Color _labelGray = Color(0xFFC8C8C8);
  static const Color _limeGreen = Color(0xFF7CFF6B);

  static const double _centerScoreFontScale = 0.34;
  static const double _centerPercentFontScale = 0.20;
  static const double _gaugeContentScale = 0.82;
  static const double _labelFontScale = 0.062;
  static const double _labelOpacity = 0.78;
  static const double _labelGapScale = 0.034;
  static const double _tickOuterScale = 0.912;
  static const double _majorTickInnerScale = 0.850;
  static const double _minorTickInnerScale = 0.878;
  static const double _cyanRingScale = 0.915;
  static const double _techBandOuterScale = 0.905;
  static const double _techBandInnerScale = 0.838;
  static const double _arcRadiusScale = 0.78;
  static const double _arcStrokeScale = 0.078;
  static const double _markerRadiusScale = 0.058;

  static const double _innerRingScale = 0.44;
  static const double _innerGreenBorderScale = 0.45;

  static const double _innerBandInnerScale = 0.64;
  static const double _innerBandOuterScale = 0.72;

  static const double _innerTickInnerScale = 0.54;
  static const double _innerTickOuterScale = 0.63;

  double get _progress {
    return (score / 100).clamp(0.0, 1.0) * animationValue;
  }

  double get _progressAngle => _sweepAngle * _progress;

  double get _displayedScore => score * animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    // Inset the gauge assembly so labels sit outside the cyan ring,
    // matching the original. Relative ring/arc/tick geometry is unchanged.
    final gaugeRadius = radius * _gaugeContentScale;

    _drawBackgroundGlow(canvas, center, radius);

    _drawInnerRing(canvas, center, gaugeRadius);

    _drawOuterCyanRing(canvas, center, gaugeRadius);
    _drawTechnicalBand(canvas, center, gaugeRadius);
    _drawOuterTicks(canvas, center, gaugeRadius);
    _drawScaleLabels(canvas, center, radius);

    _drawInnerTechnicalBand(canvas, center, gaugeRadius);
    _drawInnerGreenBorder(canvas, center, gaugeRadius);
    _drawInnerTicks(canvas, center, gaugeRadius);
    _drawInnerBorderGlow(canvas, center, gaugeRadius);

    _drawMainArc(canvas, center, gaugeRadius);
    _drawScoreMarker(canvas, center, gaugeRadius);
    _drawBottomHighlight(canvas, center, gaugeRadius);
    _drawCenterScore(canvas, center, gaugeRadius);
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
          _limeGreen.withValues(alpha: 0.05),
          _limeGreen.withValues(alpha: 0.02),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(rect);

    canvas.drawCircle(center, radius, paint);
  }

  void _drawOuterTicks(Canvas canvas, Offset center, double radius) {
    const tickCount = 200;
    final tickOuterRadius = radius * _tickOuterScale;
    final majorInnerRadius = radius * _majorTickInnerScale;
    final minorInnerRadius = radius * _minorTickInnerScale;

    final majorPaint = Paint()
      ..color = AppColors.accentCyan.withValues(alpha: 0.88)
      ..strokeWidth = radius * 0.0042
      ..strokeCap = StrokeCap.butt;

    final minorPaint = Paint()
      ..color = AppColors.accentCyan.withValues(alpha: 0.32)
      ..strokeWidth = radius * 0.0016
      ..strokeCap = StrokeCap.butt;

    for (var i = 0; i <= tickCount; i++) {
      final tickProgress = i / tickCount;
      final angle = _startAngle + _sweepAngle * tickProgress;
      final isMajor = i % 20 == 0;
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
    final fontSize = radius * _labelFontScale;
    final ringRadius = radius * _gaugeContentScale * _cyanRingScale;
    final gap = radius * _labelGapScale;

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
            fontWeight: FontWeight.w400,
            letterSpacing: 0.6,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      // Keep a consistent gap from the cyan ring to the inner edge of each
      // horizontal label, matching the original (not a shared label circle).
      final inwardExtent =
          (textPainter.width / 2) * math.cos(angle).abs() +
          (textPainter.height / 2) * math.sin(angle).abs();
      final labelRadius = ringRadius + gap + inwardExtent;
      final labelCenter = _point(center, labelRadius, angle);
      textPainter.paint(
        canvas,
        labelCenter - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
  }

  void _drawOuterCyanRing(Canvas canvas, Offset center, double radius) {
    final ringRadius = radius * _cyanRingScale;
    final ringRect = Rect.fromCircle(center: center, radius: ringRadius);

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.014
      ..color = AppColors.accentCyan.withValues(alpha: 0.16);

    final topGlowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.016
      ..strokeCap = StrokeCap.round
      ..color = AppColors.accentCyan.withValues(alpha: 0.28);

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.0036
      ..color = AppColors.accentCyan.withValues(alpha: 0.82);

    canvas.drawCircle(center, ringRadius, glowPaint);
    // Stronger bloom near 12 o'clock, matching the reference ring.
    canvas.drawArc(
      ringRect,
      -math.pi / 2 - math.pi / 10,
      math.pi / 5,
      false,
      topGlowPaint,
    );
    canvas.drawCircle(center, ringRadius, ringPaint);
  }

  void _drawTechnicalBand(Canvas canvas, Offset center, double radius) {
    final outerRadius = radius * _techBandOuterScale;
    final innerRadius = radius * _techBandInnerScale;
    final bandRadius = (innerRadius + outerRadius) / 2;

    final bandPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerRadius - innerRadius
      ..color = const Color(0xFF082028).withValues(alpha: 0.55);

    canvas.drawCircle(center, bandRadius, bandPaint);

    const divisions = 400;
    final linePaint = Paint()
      ..color = const Color(0xFF4EC8C8).withValues(alpha: 0.34)
      ..strokeWidth = radius * 0.0018
      ..strokeCap = StrokeCap.butt;

    final accentPaint = Paint()
      ..color = const Color(0xFF7AEAEA).withValues(alpha: 0.52)
      ..strokeWidth = radius * 0.0024
      ..strokeCap = StrokeCap.butt;

    for (var i = 0; i < divisions; i++) {
      final angle = (2 * math.pi * i) / divisions;
      final isAccent = i % 10 == 0;

      canvas.drawLine(
        _point(center, innerRadius, angle),
        _point(center, outerRadius, angle),
        isAccent ? accentPaint : linePaint,
      );
    }
  }

  void _drawMainArc(Canvas canvas, Offset center, double radius) {
    final arcRadius = radius * _arcRadiusScale;
    final strokeWidth = radius * _arcStrokeScale;
    final rect = Rect.fromCircle(center: center, radius: arcRadius);
    const arcGreen = Color(0xFF7CFF6B);

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF161816);

    canvas.drawArc(rect, _startAngle, _sweepAngle, false, trackPaint);

    if (_progress <= 0) {
      return;
    }

    // Wider unblurred under-stroke so the neon bloom reads on Impeller,
    // where MaskFilter.blur on arcs is often dropped.
    final bloomPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 1.40
      ..strokeCap = StrokeCap.round
      ..color = arcGreen.withValues(alpha: 0.22);

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = arcGreen;

    canvas.drawArc(rect, _startAngle, _progressAngle, false, bloomPaint);
    canvas.drawArc(rect, _startAngle, _progressAngle, false, arcPaint);
  }

  void _drawScoreMarker(Canvas canvas, Offset center, double radius) {
    final arcRadius = radius * _arcRadiusScale;
    final angle = _startAngle + _progressAngle;
    final markerCenter = _point(center, arcRadius, angle);
    final markerRadius = radius * _markerRadiusScale;
    const markerGreen = Color(0xFF7CFF6B);

    // Impeller-safe glow: concentric unblurred discs. MaskFilter is dropped.
    canvas.drawCircle(
      markerCenter,
      markerRadius * 1.85,
      Paint()..color = markerGreen.withValues(alpha: 0.14),
    );
    canvas.drawCircle(
      markerCenter,
      markerRadius * 1.40,
      Paint()..color = markerGreen.withValues(alpha: 0.28),
    );

    final fillPaint = Paint()
      ..shader =
          RadialGradient(
            center: const Alignment(-0.42, -0.42),
            colors: [
              const Color(0xFFF5FFE8),
              markerGreen,
              const Color(0xFF1A6B22),
              const Color(0xFF0A3010),
            ],
            stops: const [0.0, 0.38, 0.78, 1.0],
          ).createShader(
            Rect.fromCircle(center: markerCenter, radius: markerRadius),
          );

    canvas.drawCircle(markerCenter, markerRadius, fillPaint);

    final highlightPaint = Paint()..color = Colors.white.withValues(alpha: 0.88);
    canvas.drawCircle(
      markerCenter + Offset(-markerRadius * 0.30, -markerRadius * 0.30),
      markerRadius * 0.20,
      highlightPaint,
    );
  }

  void _drawInnerRing(Canvas canvas, Offset center, double radius) {
    final innerRadius = radius * _innerRingScale;

    final fillPaint = Paint()
      ..shader = RadialGradient(
        colors: const [
          Color(0xFF010301),
          Color(0xFF05100A),
          Color(0xFF1C4A24),
        ],
        stops: const [0.0, 0.52, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: innerRadius));
    canvas.drawCircle(center, innerRadius, fillPaint);
  }

  void _drawInnerGreenBorder(Canvas canvas, Offset center, double radius) {
    final borderRadius = radius * _innerGreenBorderScale;

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.008
      ..color = const Color(0xFF7CFF6B).withValues(alpha: 0.70);

    canvas.drawCircle(center, borderRadius, borderPaint);
  }

  void _drawInnerTechnicalBand(Canvas canvas, Offset center, double radius) {
    final outerRadius = radius * _innerBandOuterScale;
    final innerRadius = radius * _innerBandInnerScale;
    final bandRadius = (innerRadius + outerRadius) / 2;

    final bandPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerRadius - innerRadius
      ..color = const Color(0xFF0C1418).withValues(alpha: 0.55);
    canvas.drawCircle(center, bandRadius, bandPaint);

    const divisions = 280;
    final linePaint = Paint()
      ..color = const Color(0xFF4A6A78).withValues(alpha: 0.62)
      ..strokeWidth = radius * 0.0022
      ..strokeCap = StrokeCap.butt;

    final accentPaint = Paint()
      ..color = const Color(0xFF5A8290).withValues(alpha: 0.78)
      ..strokeWidth = radius * 0.0026
      ..strokeCap = StrokeCap.butt;

    for (var i = 0; i < divisions; i++) {
      final angle = (2 * math.pi * i) / divisions;
      final isAccent = i % 8 == 0;

      canvas.drawLine(
        _point(center, innerRadius, angle),
        _point(center, outerRadius, angle),
        isAccent ? accentPaint : linePaint,
      );
    }
  }

  void _drawInnerBorderGlow(Canvas canvas, Offset center, double radius) {
    final discRadius = radius * _innerRingScale;
    const glowGreen = Color(0xFF7CFF6B);
    final discRect = Rect.fromCircle(center: center, radius: discRadius);

    // Subtle lime light confined to the disc rim, fading quickly toward the
    // darker center so the interior stays dark (recessed-bowl depth).
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.transparent,
          glowGreen.withValues(alpha: 0.04),
          glowGreen.withValues(alpha: 0.14),
        ],
        stops: const [0.55, 0.82, 1.0],
      ).createShader(discRect);
    canvas.drawCircle(center, discRadius, glowPaint);

    // Thin, controlled green rim around the disc edge.
    final rimGlow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.010
      ..color = glowGreen.withValues(alpha: 0.12);
    canvas.drawCircle(center, discRadius, rimGlow);

    // Lower green crescent: luminous rim glow from ~4 o'clock to ~8 o'clock
    // with a dip at 6 o'clock for the cyan highlight.
    // Flutter drawArc: 0 rad = 3 o'clock, positive sweep = clockwise,
    // so 6 o'clock = pi/2. Do NOT rely on MaskFilter alone — Impeller can
    // clip/drop blurred strokes, which is why the previous crescent vanished.
    // Stroke sits just inside the disc so it contrasts against the dark fill.
    const rightStart = 30 * math.pi / 180; // 4 o'clock
    const flankSweep = 48 * math.pi / 180; // to ~5:36
    const leftStart = math.pi - rightStart - flankSweep; // ~6:24 to 8 o'clock
    final inwardRadius = discRadius - radius * 0.018;
    final crescentRect = Rect.fromCircle(center: center, radius: inwardRadius);

    void drawFlanks(Paint paint) {
      canvas.drawArc(crescentRect, rightStart, flankSweep, false, paint);
      canvas.drawArc(crescentRect, leftStart, flankSweep, false, paint);
    }

    canvas.save();
    canvas.clipPath(Path()..addOval(discRect));

    drawFlanks(
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius * 0.070
        ..strokeCap = StrokeCap.round
        ..color = glowGreen.withValues(alpha: 0.20),
    );
    drawFlanks(
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius * 0.038
        ..strokeCap = StrokeCap.round
        ..color = glowGreen.withValues(alpha: 0.42),
    );
    drawFlanks(
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius * 0.016
        ..strokeCap = StrokeCap.round
        ..color = glowGreen.withValues(alpha: 0.78),
    );

    canvas.restore();
  }

  void _drawInnerTicks(Canvas canvas, Offset center, double radius) {
    const tickCount = 36;
    final tickInnerRadius = radius * _innerTickInnerScale;
    final tickOuterRadius = radius * _innerTickOuterScale;
    final strokeWidth = radius * 0.011;
    const tickGreen = Color(0xFF7CFF6B);

    // Short thick strips just outside the compact inner disc, occupying the
    // radial gap opened in Phase 1. Top arc ~10 o'clock to ~2 o'clock.
    // No MaskFilter: Impeller drops blurred strokes.
    const tickStart = 7 * math.pi / 6;
    const tickSweep = 2 * math.pi / 3;

    final tickPaint = Paint()
      ..color = tickGreen.withValues(alpha: 0.95)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    for (var i = 0; i <= tickCount; i++) {
      final angle = tickStart + tickSweep * (i / tickCount);
      canvas.drawLine(
        _point(center, tickInnerRadius, angle),
        _point(center, tickOuterRadius, angle),
        tickPaint,
      );
    }
  }

  void _drawBottomHighlight(Canvas canvas, Offset center, double radius) {
    final markerY = center.dy + radius * _innerGreenBorderScale;
    final markerWidth = radius * 0.09;

    final glowPaint = Paint()
      ..color = AppColors.accentCyan.withValues(alpha: 0.28)
      ..strokeWidth = radius * 0.022
      ..strokeCap = StrokeCap.round;

    final paint = Paint()
      ..color = AppColors.accentCyan.withValues(alpha: 0.95)
      ..strokeWidth = radius * 0.010
      ..strokeCap = StrokeCap.round;

    final start = Offset(center.dx - markerWidth / 2, markerY);
    final end = Offset(center.dx + markerWidth / 2, markerY);
    canvas.drawLine(start, end, glowPaint);
    canvas.drawLine(start, end, paint);
  }

  void _drawCenterScore(Canvas canvas, Offset center, double radius) {
    final numberSize = radius * _centerScoreFontScale;
    final percentSize = radius * _centerPercentFontScale;

    final numberPainter = TextPainter(
      text: TextSpan(
        text: '${_displayedScore.round()}',
        style: AppTextStyles.gaugeScore.copyWith(
          color: Colors.white,
          fontSize: numberSize,
          fontWeight: FontWeight.w600,
          height: 1.0,
          letterSpacing: -1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final percentPainter = TextPainter(
      text: TextSpan(
        text: '%',
        style: AppTextStyles.gaugeScore.copyWith(
          color: Colors.white,
          fontSize: percentSize,
          fontWeight: FontWeight.w500,
          height: 1.0,
          letterSpacing: 0,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final gap = radius * 0.012;
    final totalWidth = numberPainter.width + gap + percentPainter.width;
    final numberOffset = Offset(
      center.dx - totalWidth / 2,
      center.dy - numberPainter.height / 2,
    );
    final percentOffset = Offset(
      numberOffset.dx + numberPainter.width + gap,
      center.dy - percentPainter.height / 2 - numberSize * 0.06,
    );

    numberPainter.paint(canvas, numberOffset);
    percentPainter.paint(canvas, percentOffset);
  }

  @override
  bool shouldRepaint(WellnessGaugePainter oldDelegate) {
    return oldDelegate.score != score ||
        oldDelegate.animationValue != animationValue;
  }
}
