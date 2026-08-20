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
import 'package:health_data_hub/widgets/gauges/provided_score_gauge.dart';
import 'package:health_data_hub/widgets/genotype/dna_visual.dart';
import 'package:health_data_hub/widgets/genotype/genotype_toggle.dart';
import 'package:health_data_hub/widgets/genotype/hormone_chip.dart';
import 'package:health_data_hub/widgets/genotype/hormone_info_card.dart';
import 'package:health_data_hub/widgets/genotype/section_dropdown_menu.dart';
import 'package:health_data_hub/widgets/wellness/range_legend_grid.dart';

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
                  final dnaHeight =
                      (constraints.maxWidth * 0.95).clamp(280.0, 380.0);
                  final gaugeSize =
                      (constraints.maxWidth * 0.82).clamp(260.0, 320.0);

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
                        SectionSelectorAnchor(controller: controller),
                        const SizedBox(height: 12),
                        Obx(
                          () => _HormoneHero(
                            height: dnaHeight,
                            hormones: controller.hormones,
                            selectedName:
                                controller.selectedHormoneName.value,
                            onSelect: controller.selectHormone,
                          ),
                        ),
                        Obx(
                          () => _HormoneDetail(
                            hormone: controller.selectedHormone,
                            gaugeSize: gaugeSize,
                            ranges: controller.scoreRanges,
                          ),
                        ),
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
          CustomPaint(
            size: Size.infinite,
            painter: _HeroConnectorPainter(
              alignments: [
                for (final hormone in hormones) _alignmentFor(hormone.name),
              ],
              selectedIndex: hormones.indexWhere(
                (hormone) => hormone.name == selectedName,
              ),
            ),
          ),
          DnaVisual(height: height),
          for (final hormone in hormones)
            Align(
              alignment: _alignmentFor(hormone.name),
              child: HormoneChip(
                label: hormone.name,
                subtitle: hormone.name == 'OXTR' ? hormone.subtitle : null,
                selected: hormone.name == selectedName,
                onTap: () => onSelect(hormone.name),
              ),
            ),
        ],
      ),
    );
  }
}

class _HeroConnectorPainter extends CustomPainter {
  _HeroConnectorPainter({
    required this.alignments,
    required this.selectedIndex,
  });

  final List<Alignment> alignments;
  final int selectedIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final origin = Offset(size.width / 2, size.height * 0.46);

    for (var i = 0; i < alignments.length; i++) {
      final alignment = alignments[i];
      final target = Offset(
        (alignment.x + 1) / 2 * size.width,
        (alignment.y + 1) / 2 * size.height,
      );
      final selected = i == selectedIndex;
      final paint = Paint()
        ..color = selected
            ? const Color(0xFF48AF3C).withValues(alpha: 0.78)
            : AppColors.accentCyan.withValues(alpha: 0.22)
        ..strokeWidth = selected ? 1.5 : 0.9
        ..style = PaintingStyle.stroke;

      canvas.drawLine(origin, target, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _HeroConnectorPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}

class _HormoneDetail extends StatelessWidget {
  const _HormoneDetail({
    required this.hormone,
    required this.gaugeSize,
    required this.ranges,
  });

  final HormoneData hormone;
  final double gaugeSize;
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
        if (hormone.hasRegulationScore) ...[
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: gaugeSize,
              height: gaugeSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IgnorePointer(
                    child: Container(
                      width: gaugeSize * 0.72,
                      height: gaugeSize * 0.72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF48AF3C).withValues(
                              alpha: 0.22,
                            ),
                            blurRadius: 48,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ProvidedScoreGauge(
                    key: ValueKey(hormone.name),
                    asset: AppAssets.gaugeGreen,
                    score: hormone.level,
                    size: gaugeSize,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          RangeLegendGrid(ranges: ranges),
          const SizedBox(height: 24),
          HormoneInfoCard(hormone: hormone),
        ],
        if (hormone.hasAbout) ...[
          SizedBox(
            height: hormone.hasRegulationScore ? AppConstants.sectionGap : 16,
          ),
          HormoneAboutSection(hormone: hormone),
        ],
        const SizedBox(height: 24),
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
        child: SizedBox(
          height: 640,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, -0.08),
                    radius: 1.55,
                    colors: [
                      AppColors.accentCyan.withValues(alpha: 0.14),
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
                  width: 240,
                  height: 640,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF48AF3C).withValues(alpha: 0.10),
                        const Color(0xFF48AF3C).withValues(alpha: 0.05),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.52, 1.0],
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
