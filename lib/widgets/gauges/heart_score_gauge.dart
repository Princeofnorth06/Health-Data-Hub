import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';

class HeartScoreGauge extends StatelessWidget {
  const HeartScoreGauge({
    super.key,
    required this.score,
    required this.badgeLabel,
    required this.badgeValue,
  });

  final double score;
  final String badgeLabel;
  final double badgeValue;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.55,
      child: CustomPaint(
        painter: HeartScoreGaugePainter(
          score: score,
          badgeLabel: badgeLabel,
          badgeValue: badgeValue,
        ),
      ),
    );
  }
}

class HeartScoreGaugePainter extends CustomPainter {
  HeartScoreGaugePainter({
    required this.score,
    required this.badgeLabel,
    required this.badgeValue,
  });

  final double score;
  final String badgeLabel;
  final double badgeValue;

  static const List<Color> _segments = [
    Color(0xFFE53935),
    Color(0xFFFF8A3D),
    Color(0xFFFFD54F),
    Color(0xFFC6E85A),
    Color(0xFF7CFF6B),
    Color(0xFF2E7D32),
  ];

  static const List<String> _labels = [
    'VERY LOW',
    'LOW',
    'MODERATE',
    'OPTIAL',
    'HIGH',
    'VERY HIGH',
  ];

  static const double _startAngle = math.pi;
  static const double _sweep = math.pi;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.78);
    final radius = size.width * 0.42;
    final stroke = size.width * 0.055;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke + 6
      ..strokeCap = StrokeCap.butt
      ..color = const Color(0xFF0A1208);
    canvas.drawArc(rect, _startAngle, _sweep, false, track);

    final slice = _sweep / _segments.length;
    for (var i = 0; i < _segments.length; i++) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.butt
        ..color = _segments[i]
        ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 0.4);
      canvas.drawArc(rect, _startAngle + slice * i, slice * 0.96, false, paint);
    }

    final labelRadius = radius + stroke * 1.8;
    final labelStyle = AppTextStyles.gaugeLabel.copyWith(
      fontSize: size.width * 0.028,
      color: const Color(0xFFB8B8B8),
    );
    for (var i = 0; i < _labels.length; i++) {
      final angle = _startAngle + slice * (i + 0.5);
      final pos = Offset(
        center.dx + math.cos(angle) * labelRadius,
        center.dy + math.sin(angle) * labelRadius,
      );
      _paintCenteredText(canvas, _labels[i], pos, labelStyle);
    }

    final t = (score / 100).clamp(0.0, 1.0);
    final needleAngle = _startAngle + _sweep * t;
    final needleLen = radius - stroke * 0.2;
    final tip = Offset(
      center.dx + math.cos(needleAngle) * needleLen,
      center.dy + math.sin(needleAngle) * needleLen,
    );

    final needle = Paint()
      ..color = const Color(0xFFE8E8E8)
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, tip, needle);

    canvas.drawCircle(center, 7, Paint()..color = Colors.white);
    canvas.drawCircle(center, 3.5, Paint()..color = const Color(0xFF111111));

    _paintBadge(canvas, size, center);
  }

  void _paintBadge(Canvas canvas, Size size, Offset hub) {
    final text = '$badgeLabel ${badgeValue.toStringAsFixed(1)}';
    final style = AppTextStyles.chipLabel.copyWith(
      color: const Color(0xFFFFD54F),
      fontSize: 11,
    );
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    final pad = const Offset(10, 6);
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(hub.dx, hub.dy + 28),
        width: tp.width + pad.dx * 2,
        height: tp.height + pad.dy * 2,
      ),
      const Radius.circular(6),
    );
    canvas.drawRRect(rect, Paint()..color = const Color(0xFF0A0A0A));
    canvas.drawRRect(
      rect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = const Color(0xFFFFD54F),
    );
    tp.paint(
      canvas,
      Offset(rect.left + pad.dx, rect.top + pad.dy),
    );
  }

  void _paintCenteredText(
    Canvas canvas,
    String text,
    Offset center,
    TextStyle style,
  ) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(HeartScoreGaugePainter oldDelegate) {
    return oldDelegate.score != score ||
        oldDelegate.badgeLabel != badgeLabel ||
        oldDelegate.badgeValue != badgeValue;
  }
}
