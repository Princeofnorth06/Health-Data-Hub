import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/core/constants/app_assets.dart';

class DnaVisual extends StatelessWidget {
  const DnaVisual({super.key, this.height = 300});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const _PlatformGlow(),
          Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: Image.asset(
              AppAssets.dnaHero,
              fit: BoxFit.contain,
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: _HolographicPlatform(),
          ),
        ],
      ),
    );
  }
}

class _PlatformGlow extends StatelessWidget {
  const _PlatformGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
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
    );
  }
}

class _HolographicPlatform extends StatelessWidget {
  const _HolographicPlatform();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: 220,
      child: CustomPaint(
        painter: _PlatformPainter(),
      ),
    );
  }
}

class _PlatformPainter extends CustomPainter {
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

    final fill = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.accentCyan.withValues(alpha: 0.22),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: size.width / 2));

    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.72,
        height: size.height * 0.34,
      ),
      fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
