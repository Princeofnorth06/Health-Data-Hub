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
import 'package:health_data_hub/widgets/common/section_title.dart';
import 'package:health_data_hub/widgets/gauges/wellness_gauge.dart';
import 'package:health_data_hub/widgets/wellness/genetic_strength_card.dart';
import 'package:health_data_hub/widgets/wellness/range_item.dart';
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
                    WellnessGauge(score: wellness.score),
                    const SizedBox(height: AppConstants.sectionGap),
                    const SectionTitle(title: 'RANGES'),
                    const SizedBox(height: AppConstants.itemGap),
                    for (final range in wellness.ranges) ...[
                      RangeItem(range: range),
                      const SizedBox(height: AppConstants.itemGap),
                    ],
                    const SizedBox(height: 8),
                    GeneticStrengthCard(items: controller.strengths),
                    const SizedBox(height: AppConstants.sectionGap),
                    RecommendationCard(
                      title: 'Personalized Wellness Suggestions',
                      genotypeScore: wellness.genotypeScore,
                      items: wellness.suggestions,
                      emphasized: true,
                    ),
                    const SizedBox(height: AppConstants.sectionGap),
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
          child: Transform.rotate(
            angle: 0.7, // radians
            child: Image.asset(
              AppAssets.dnaHelix,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
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
        child: Container(
          height: 320,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -0.2),
              radius: 0.85,
              colors: [
                AppColors.primary.withValues(alpha: 0.22),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
