import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_data_hub/app/routes/app_routes.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/controllers/wellness_controller.dart';
import 'package:health_data_hub/core/constants/app_assets.dart';
import 'package:health_data_hub/core/constants/app_constants.dart';
import 'package:health_data_hub/widgets/common/app_back_button.dart';
import 'package:health_data_hub/widgets/gauges/wellness_gauge.dart';
import 'package:health_data_hub/widgets/wellness/genetic_strength_card.dart';
import 'package:health_data_hub/widgets/wellness/range_legend_grid.dart';
import 'package:health_data_hub/widgets/wellness/recommendation_card.dart';

class WellnessScreen extends GetView<WellnessController> {
  const WellnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wellness = controller.wellness;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            const _TopGlow(),
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
                    const _WellnessHeader(),
                    const SizedBox(height: AppConstants.sectionGap),
                    const _ScoreSectionTitle(),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: WellnessGauge(score: wellness.score),
                    ),
                    const SizedBox(height: AppConstants.sectionGap),
                    RangeLegendGrid(ranges: wellness.ranges),
                    const SizedBox(height: 24),
                    GeneticStrengthCard(items: controller.strengths),
                    const SizedBox(height: 18),
                    RecommendationCard(
                      title: 'Personalized Wellness\nSuggestions',
                      genotypeScore: wellness.genotypeScore,
                      items: wellness.suggestions,
                      emphasized: true,
                    ),
                    const SizedBox(height: 24),
                    RecommendationCard(
                      title: 'Recommendations',
                      items: wellness.recommendations,
                    ),
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

class _WellnessHeader extends StatelessWidget {
  const _WellnessHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AppBackButton(),
        Expanded(
          child: Text(
            'Genotype',
            textAlign: TextAlign.center,
            style: AppTextStyles.screenTitle,
          ),
        ),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.textPrimary.withValues(alpha: 0.7),
            ),
          ),
          padding: const EdgeInsets.all(6),
          child: GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.heartScore),
            child: Transform.rotate(
              angle: 0.7, // radians
              child: Image.asset(AppAssets.dnaHelix, fit: BoxFit.contain),
            ),
          ),
        ),
      ],
    );
  }
}

/// Provided decorative gauge (`assets/images/decorative/gauge_green.png`).
/// Center 76% is covered so the live wellness score can be shown.
class _ProvidedWellnessGauge extends StatelessWidget {
  const _ProvidedWellnessGauge({required this.score});

  final double score;

  static const double _size = 300;
  static const Color _centerFill = Color(0xFF0D0E17);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size,
      height: _size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppAssets.gaugeGreen,
            width: _size,
            height: _size,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
          Container(
            width: 88,
            height: 88,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: _centerFill,
            ),
          ),
          Text(
            '${score.round()}%',
            style: AppTextStyles.gaugeScore,
          ),
        ],
      ),
    );
  }
}

class _ScoreSectionTitle extends StatelessWidget {
  const _ScoreSectionTitle();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.genotype),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                'Overall Wellness Score',
                style: AppTextStyles.displayMedium,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopGlow extends StatelessWidget {
  const _TopGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 700,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, -0.05),
                    radius: 1.75,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.18),
                      AppColors.primary.withValues(alpha: 0.08),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.42, 1.0],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 260,
                  height: 700,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF48AF3C).withValues(alpha: 0.10),
                        const Color(0xFF48AF3C).withValues(alpha: 0.07),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.58, 1.0],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
