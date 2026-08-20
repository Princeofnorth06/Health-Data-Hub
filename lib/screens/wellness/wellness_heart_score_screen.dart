import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/controllers/wellness_controller.dart';
import 'package:health_data_hub/core/constants/app_constants.dart';
import 'package:health_data_hub/data/models/heart_score_data.dart';
import 'package:health_data_hub/widgets/common/section_title.dart';
import 'package:health_data_hub/widgets/gauges/heart_score_gauge.dart';

class WellnessHeartScoreScreen extends GetView<WellnessController> {
  const WellnessHeartScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = controller.heartScore;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            const _GreenAtmosphere(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.pagePadding,
                  8,
                  AppConstants.pagePadding,
                  32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _HeartHeader(),
                    const SizedBox(height: 20),
                    Text(
                      '${data.score.toStringAsFixed(1)} %',
                      style: AppTextStyles.gaugeScore.copyWith(fontSize: 36),
                    ),
                    Text(data.status, style: AppTextStyles.caption),
                    const SizedBox(height: 8),
                    HeartScoreGauge(
                      score: data.score,
                      badgeLabel: data.badgeLabel,
                      badgeValue: data.badgeValue,
                    ),
                    const SizedBox(height: 8),
                    const SectionTitle(title: 'RANGES'),
                    const SizedBox(height: 16),
                    _RangesGrid(ranges: data.ranges),
                    const SizedBox(height: 24),
                    Text(data.parametersIntro, style: AppTextStyles.caption),
                    const SizedBox(height: 12),
                    for (final parameter in data.parameters) ...[
                      _ParameterCard(parameter: parameter),
                      const SizedBox(height: 10),
                    ],
                    const SizedBox(height: 16),
                    Text(
                      'ABOUT SLC6A4 Heart Score (${data.score.toStringAsFixed(1)} %)',
                      style: AppTextStyles.heading,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 1.5,
                      width: 170,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF00C5FB),
                            Color(0x0000C5FB),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(data.about, style: AppTextStyles.body),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeartHeader extends StatelessWidget {
  const _HeartHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1A1A1A),
              border: Border.all(
                color: AppColors.textPrimary.withValues(alpha: 0.35),
              ),
            ),
            child: const Icon(
              Icons.chevron_left,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'SLC6A4 Heart Score',
            textAlign: TextAlign.center,
            style: AppTextStyles.screenTitle.copyWith(fontSize: 16),
          ),
        ),
        const SizedBox(width: 44),
      ],
    );
  }
}

class _RangesGrid extends StatelessWidget {
  const _RangesGrid({required this.ranges});

  final List<HeartRange> ranges;

  static const Map<String, Color> _tones = {
    'veryLow': Color(0xFFE53935),
    'low': Color(0xFFFF8A3D),
    'moderate': Color(0xFFFFD54F),
    'optimal': Color(0xFFC6E85A),
    'high': Color(0xFF7CFF6B),
    'veryHigh': Color(0xFF2E7D32),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < ranges.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _RangeCell(range: ranges[i], tones: _tones)),
                const SizedBox(width: 16),
                Expanded(
                  child: i + 1 < ranges.length
                      ? _RangeCell(range: ranges[i + 1], tones: _tones)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _RangeCell extends StatelessWidget {
  const _RangeCell({required this.range, required this.tones});

  final HeartRange range;
  final Map<String, Color> tones;

  @override
  Widget build(BuildContext context) {
    final color = tones[range.tone] ?? AppColors.textSecondary;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.55),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(range.value, style: AppTextStyles.rangeLabel),
              const SizedBox(height: 2),
              Text(
                range.label,
                style: AppTextStyles.caption.copyWith(letterSpacing: 0.6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ParameterCard extends StatelessWidget {
  const _ParameterCard({required this.parameter});

  final HeartParameter parameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF141414).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder.withValues(alpha: 0.7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _GoldBadge(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(parameter.title, style: AppTextStyles.bodyLarge),
                const SizedBox(height: 4),
                Text(parameter.body, style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textSecondary,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class _GoldBadge extends StatelessWidget {
  const _GoldBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFFC9A227),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFC9A227).withValues(alpha: 0.45),
            blurRadius: 8,
          ),
        ],
      ),
      child: const Icon(Icons.check, size: 16, color: Color(0xFF1A1408)),
    );
  }
}

class _GreenAtmosphere extends StatelessWidget {
  const _GreenAtmosphere();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 360,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -0.1),
              radius: 0.95,
              colors: [
                const Color(0xFF48AF3C).withValues(alpha: 0.22),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
