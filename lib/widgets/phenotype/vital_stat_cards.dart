import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/data/models/blood_metrics.dart';

class VitalStatCards extends StatelessWidget {
  const VitalStatCards({super.key, required this.metrics});

  final BloodMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _VitalCard(
            title: metrics.sugarLabel,
            value: metrics.sugarValue,
            status: metrics.sugarStatus,
            accent: const Color(0xFFE8A04A),
            fillStart: const Color(0xFF2A1808),
            fillEnd: const Color(0xFF0C0804),
            icon: Icons.monitor_heart_outlined,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _VitalCard(
            title: metrics.bpLabel,
            value: metrics.bpValue,
            status: metrics.bpStatus,
            accent: const Color(0xFF2EE6D6),
            fillStart: const Color(0xFF082028),
            fillEnd: const Color(0xFF041014),
            icon: Icons.water_drop_outlined,
          ),
        ),
      ],
    );
  }
}

class _VitalCard extends StatelessWidget {
  const _VitalCard({
    required this.title,
    required this.value,
    required this.status,
    required this.accent,
    required this.fillStart,
    required this.fillEnd,
    required this.icon,
  });

  final String title;
  final String value;
  final String status;
  final Color accent;
  final Color fillStart;
  final Color fillEnd;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [fillStart, fillEnd],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withValues(alpha: 0.38)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.22),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accent, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.chipLabel.copyWith(fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: AppTextStyles.bodyLarge.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: AppTextStyles.chipLabel.copyWith(
                color: accent,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 32,
            width: double.infinity,
            child: CustomPaint(
              painter: _SparklinePainter(color: accent),
            ),
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  const _SparklinePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (var i = 0; i <= 24; i++) {
      final x = size.width * i / 24;
      final y = size.height * (0.52 + 0.38 * math.sin(i * 0.55));
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final fill = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.28),
            color.withValues(alpha: 0.0),
          ],
        ).createShader(Offset.zero & size),
    );

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = 1.8
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = 1.6
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
