import 'package:flutter/material.dart';
import 'package:health_data_hub/widgets/common/section_title.dart';
import 'package:health_data_hub/widgets/gauges/wellness_gauge.dart';
import 'package:health_data_hub/widgets/wellness/genetic_strength_card.dart';
import 'package:health_data_hub/widgets/wellness/range_item.dart';
import 'package:health_data_hub/widgets/wellness/recommendation_card.dart';

class WellnessScreen extends StatelessWidget {
  const WellnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: 'Wellness'),
              SizedBox(height: 16),
              WellnessGauge(),
              SizedBox(height: 16),
              RangeItem(),
              SizedBox(height: 12),
              GeneticStrengthCard(),
              SizedBox(height: 12),
              RecommendationCard(),
            ],
          ),
        ),
      ),
    );
  }
}
