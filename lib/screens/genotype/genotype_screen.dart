import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/controllers/genotype_controller.dart';
import 'package:health_data_hub/core/constants/app_assets.dart';
import 'package:health_data_hub/core/constants/app_constants.dart';
import 'package:health_data_hub/data/models/hormone_data.dart';
import 'package:health_data_hub/data/models/wellness_data.dart';
import 'package:health_data_hub/widgets/common/app_back_button.dart';
import 'package:health_data_hub/widgets/common/section_title.dart';
import 'package:health_data_hub/widgets/gauges/hormone_score_gauge.dart';
import 'package:health_data_hub/widgets/genotype/dna_visual.dart';
import 'package:health_data_hub/widgets/genotype/genotype_toggle.dart';
import 'package:health_data_hub/widgets/genotype/hormone_chip.dart';
import 'package:health_data_hub/widgets/genotype/hormone_info_card.dart';
import 'package:health_data_hub/widgets/genotype/section_selector.dart';
import 'package:health_data_hub/widgets/wellness/range_item.dart';

class GenotypeScreen extends GetView<GenotypeController> {
  const GenotypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            const _TopGlow(),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final dnaHeight = (constraints.maxWidth * 0.82)
                      .clamp(240.0, 340.0);
                  final gaugeWidth = (constraints.maxWidth * 0.78)
                      .clamp(220.0, 320.0);

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppConstants.pagePadding,
                      8,
                      AppConstants.pagePadding,
                      32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _GenotypeHeader(),
                        const SizedBox(height: 16),
                        Obx(
                          () => GenotypePhenotypeToggle(
                            isGenotypeSelected:
                                controller.isGenotypeSelected.value,
                            onChanged: controller.selectGenotypeTab,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SectionSelector(title: controller.sectionTitle),
                        const SizedBox(height: 12),
                        Obx(
                          () => _HormoneHero(
                            height: dnaHeight,
                            hormones: controller.hormones,
                            selectedName: controller.selectedHormoneName.value,
                            onSelect: controller.selectHormone,
                          ),
                        ),
                        Obx(() {
                          final hormone = controller.selectedHormone;
                          if (!hormone.hasDetail) {
                            return const SizedBox(height: 24);
                          }
                          return _HormoneDetail(
                            hormone: hormone,
                            gaugeWidth: gaugeWidth,
                            ranges: controller.scoreRanges,
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenotypeHeader extends StatelessWidget {
  const _GenotypeHeader();

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
            angle: 0.7,
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

class _HormoneHero extends StatelessWidget {
  const _HormoneHero({
    required this.height,
    required this.hormones,
    required this.selectedName,
    required this.onSelect,
  });

  final double height;
  final List<HormoneData> hormones;
  final String selectedName;
  final ValueChanged<String> onSelect;

  Alignment _alignmentFor(String name) {
    switch (name) {
      case 'Dopamine':
        return const Alignment(-0.92, -0.08);
      case 'Serotonin':
        return const Alignment(0.92, -0.12);
      case 'Cortisol':
        return const Alignment(-0.88, 0.38);
      case 'Melatonin':
        return const Alignment(-0.55, -0.72);
      case 'OXTR':
        return const Alignment(0.42, 0.62);
      default:
        return Alignment.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          DnaVisual(height: height),
          for (final hormone in hormones)
            Align(
              alignment: _alignmentFor(hormone.name),
              child: HormoneChip(
                label: hormone.name,
                selected: hormone.name == selectedName,
                onTap: () => onSelect(hormone.name),
              ),
            ),
        ],
      ),
    );
  }
}

class _HormoneDetail extends StatelessWidget {
  const _HormoneDetail({
    required this.hormone,
    required this.gaugeWidth,
    required this.ranges,
  });

  final HormoneData hormone;
  final double gaugeWidth;
  final List<WellnessRange> ranges;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Center(
          child: Text(
            '${hormone.name} Score',
            style: AppTextStyles.displayMedium,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: SizedBox(
            width: gaugeWidth,
            child: HormoneScoreGauge(
              key: ValueKey(hormone.name),
              score: hormone.level,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.sectionGap),
        const SectionTitle(title: 'RANGES'),
        const SizedBox(height: AppConstants.itemGap),
        for (final range in ranges) ...[
          RangeItem(range: range),
          const SizedBox(height: AppConstants.itemGap),
        ],
        const SizedBox(height: 8),
        HormoneInfoCard(hormone: hormone),
        const SizedBox(height: AppConstants.sectionGap),
        HormoneAboutSection(hormone: hormone),
      ],
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
                AppColors.primary.withValues(alpha: 0.18),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
