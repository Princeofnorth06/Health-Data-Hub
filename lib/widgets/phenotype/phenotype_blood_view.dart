import 'package:flutter/material.dart';
import 'package:health_data_hub/controllers/genotype_controller.dart';
import 'package:health_data_hub/data/models/blood_metrics.dart';
import 'package:health_data_hub/widgets/phenotype/blood_hero.dart';
import 'package:health_data_hub/widgets/phenotype/blood_quality_section.dart';
import 'package:health_data_hub/widgets/phenotype/metric_selector.dart';
import 'package:health_data_hub/widgets/phenotype/vital_stat_cards.dart';

class PhenotypeBloodView extends StatelessWidget {
  const PhenotypeBloodView({
    super.key,
    required this.controller,
    required this.heroHeight,
    required this.gaugeSize,
  });

  final GenotypeController controller;
  final double heroHeight;
  final double gaugeSize;

  @override
  Widget build(BuildContext context) {
    const metrics = BloodMetrics.current;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                const SizedBox(height: 36),
                BloodHero(height: heroHeight, metrics: metrics),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: MetricSelector(controller: controller),
            ),
          ],
        ),
        const SizedBox(height: 20),
        VitalStatCards(metrics: metrics),
        const SizedBox(height: 28),
        BloodQualitySection(gaugeSize: gaugeSize),
      ],
    );
  }
}
