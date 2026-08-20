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
  static const double _innerGreenBorderScale = 0.55;
  static const double _outerGreenBorderScale = 0.65;

  static const double _innerBandInnerScale = 0.64;
  static const double _innerBandOuterScale = 0.72;

  static const double _innerTickInnerScale = 0.44;
  static const double _innerTickOuterScale = 0.53;

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
    _drawGaugeBorders(canvas, center, gaugeRadius);

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

    // ==========================================
    // OUTER GREEN ATMOSPHERIC GLOW
    // ==========================================

    final outerGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF6DFF58).withValues(alpha: 0.22),
          const Color(0xFF45D83C).withValues(alpha: 0.10),
          const Color(0xFF45D83C).withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(
        Rect.fromCircle(
          center: markerCenter,
          radius: markerRadius * 2.0,
        ),
      );

    canvas.drawCircle(
      markerCenter,
      markerRadius * 2.0,
      outerGlowPaint,
    );

    // ==========================================
    // MAIN 3D GREEN SPHERE
    //
    // Soft light from upper-left
    // Deep green toward lower-right
    // No white specular dot
    // ==========================================

    final markerPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.35, -0.40),
        radius: 0.95,
        colors: const [
          Color(0xFF8AFF72), // soft upper-left light
          Color(0xFF5BEA45), // bright green
          Color(0xFF249B24), // rich green
          Color(0xFF0B4E13), // deep green
          Color(0xFF032507), // dark lower/right edge
        ],
        stops: [
          0.0,
          0.28,
          0.55,
          0.80,
          1.0,
        ],
      ).createShader(
        Rect.fromCircle(
          center: markerCenter,
          radius: markerRadius,
        ),
      );

    canvas.drawCircle(
      markerCenter,
      markerRadius,
      markerPaint,
    );

    // ==========================================
    // SUBTLE EDGE DEFINITION
    // ==========================================

    final edgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.004
      ..color = const Color(0xFF8CFF78).withValues(alpha: 0.35);

    canvas.drawCircle(
      markerCenter,
      markerRadius,
      edgePaint,
    );
  }
  void _drawInnerRing(Canvas canvas, Offset center, double radius) {
    final innerRadius = radius * _innerRingScale;
    final discRect = Rect.fromCircle(center: center, radius: innerRadius);

    // Deep recessed bowl: very dark core, controlled green toward the rim.
    final fillPaint = Paint()
      ..shader = RadialGradient(
        colors: const [
          Color(0xFF010301),
          Color(0xFF020704),
          Color(0xFF07160B),
          Color(0xFF163B1C),
        ],
        stops: const [0.0, 0.42, 0.76, 1.0],
      ).createShader(discRect);

    canvas.drawCircle(center, innerRadius, fillPaint);

    // Very subtle lower-half atmospheric light inside the disc.
    canvas.save();
    canvas.clipPath(Path()..addOval(discRect));

    final lowerGlowCenter = Offset(center.dx, center.dy + innerRadius * 0.82);

    final lowerGlowPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFF7CFF6B).withValues(alpha: 0.13),
              const Color(0xFF7CFF6B).withValues(alpha: 0.045),
              Colors.transparent,
            ],
            stops: const [0.0, 0.42, 1.0],
          ).createShader(
            Rect.fromCircle(
              center: lowerGlowCenter,
              radius: innerRadius * 0.85,
            ),
          );

    canvas.drawCircle(lowerGlowCenter, innerRadius * 0.85, lowerGlowPaint);

    canvas.restore();
  }







  void _drawGaugeBorders(
      Canvas canvas,
      Offset center,
      double radius,
      ) {
    final innerRadius = radius * _innerGreenBorderScale;
    final outerRadius = radius * _outerGreenBorderScale;

    // ==========================================
    // BAND BETWEEN INNER & OUTER BORDER
    // ==========================================

    final bandPath = Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: outerRadius,
        ),
      )
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: innerRadius,
        ),
      )
      ..fillType = PathFillType.evenOdd;

    final bandRect = Rect.fromCircle(
      center: center,
      radius: outerRadius,
    );

    // ==========================================
    // BASE BAND COLOR
    // Keep the existing vertical lighting:
    // top = light green
    // bottom = dark green / almost black
    // ==========================================

    final bandPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [
          Color(0xFF8CFF78),
          Color(0xFF62D957),
          Color(0xFF2E7A35),
          Color(0xFF163B1C),
          Color(0xFF08140B),
          Color(0xFF020504),
        ],
        stops: const [
          0.0,
          0.18,
          0.38,
          0.58,
          0.78,
          1.0,
        ],
      ).createShader(bandRect);

    canvas.drawPath(bandPath, bandPaint);

    // ==========================================
    // TUBE DEPTH
    //
    // Cross-section:
    // outer edge = darker
    // middle      = slightly raised/light
    // inner edge = darker
    // ==========================================

    // Outer wall shadow
    final outerTubeShadow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.022
      ..color = Colors.black.withValues(alpha: 0.24)
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        radius * 0.008,
      );

    canvas.drawCircle(
      center,
      outerRadius - radius * 0.006,
      outerTubeShadow,
    );

    // Inner wall shadow
    final innerTubeShadow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.022
      ..color = Colors.black.withValues(alpha: 0.28)
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        radius * 0.008,
      );

    canvas.drawCircle(
      center,
      innerRadius + radius * 0.006,
      innerTubeShadow,
    );

    // ==========================================
    // RAISED CENTER OF THE TUBE
    // ==========================================

    final tubeRadius = (innerRadius + outerRadius) / 2;

    final tubeHighlight = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.032
      ..color = const Color(0xFF7CFF6B).withValues(alpha: 0.16)
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        radius * 0.010,
      );

    canvas.drawCircle(
      center,
      tubeRadius,
      tubeHighlight,
    );

    // ==========================================
    // SUBTLE SPECULAR HIGHLIGHT
    //
    // Only on upper half, so the ring doesn't
    // look uniformly flat.
    // ==========================================

    final upperHighlight = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.010
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFB1FF9B).withValues(alpha: 0.16);

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: tubeRadius,
      ),
      math.pi,
      math.pi,
      false,
      upperHighlight,
    );

    // ==========================================
    // INNER GREEN BORDER
    // ==========================================

    final innerBorderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.008
      ..color = const Color(0xFF7CFF6B).withValues(alpha: 0.72);

    canvas.drawCircle(
      center,
      innerRadius,
      innerBorderPaint,
    );

    // ==========================================
    // OUTER CYAN / TEAL BORDER
    // ==========================================

    final outerBorderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.007
      ..color = const Color(0xFF18C7E8).withValues(alpha: 0.65);

    canvas.drawCircle(
      center,
      outerRadius,
      outerBorderPaint,
    );
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
    final discRect = Rect.fromCircle(center: center, radius: discRadius);

    const glowGreen = Color(0xFF7CFF6B);

    // Very subtle full rim atmosphere.
    final rimAtmosphere = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.014
      ..color = glowGreen.withValues(alpha: 0.075);

    canvas.drawCircle(center, discRadius, rimAtmosphere);

    /*
   * Reference lower rim glow:
   *
   * It is NOT a U-shaped object.
   * It is a soft bloom following the circular rim,
   * brighter on both lower flanks and leaving a dip
   * around exact 6 o'clock for the cyan highlight.
   */

    final glowRadius = discRadius - radius * 0.006;
    final glowRect = Rect.fromCircle(center: center, radius: glowRadius);

    // Right lower flank: ~4:30 -> ~5:40
    const rightStart = math.pi / 4;
    const rightSweep = math.pi / 4.8;

    // Left lower flank: ~6:20 -> ~7:30
    const leftStart = math.pi * 0.72;
    const leftSweep = math.pi / 4.8;

    canvas.save();
    canvas.clipPath(Path()..addOval(discRect));

    // Soft atmospheric base.
    final softFlankPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.030
      ..strokeCap = StrokeCap.round
      ..color = glowGreen.withValues(alpha: 0.14);

    // Smaller luminous core.
    final coreFlankPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.010
      ..strokeCap = StrokeCap.round
      ..color = glowGreen.withValues(alpha: 0.38);

    // Right flank.
    canvas.drawArc(glowRect, rightStart, rightSweep, false, softFlankPaint);

    canvas.drawArc(glowRect, rightStart, rightSweep, false, coreFlankPaint);

    // Left flank.
    canvas.drawArc(glowRect, leftStart, leftSweep, false, softFlankPaint);

    canvas.drawArc(glowRect, leftStart, leftSweep, false, coreFlankPaint);

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
