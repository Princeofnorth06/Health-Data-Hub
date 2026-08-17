import 'package:flutter/material.dart';
import 'package:health_data_hub/widgets/common/app_back_button.dart';
import 'package:health_data_hub/widgets/common/section_title.dart';
import 'package:health_data_hub/widgets/genotype/dna_visual.dart';
import 'package:health_data_hub/widgets/genotype/genotype_toggle.dart';
import 'package:health_data_hub/widgets/genotype/hormone_chip.dart';

class GenotypeScreen extends StatelessWidget {
  const GenotypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 16),
              SectionTitle(title: 'Genotype'),
              SizedBox(height: 16),
              DnaVisual(),
              SizedBox(height: 16),
              GenotypeToggle(),
              SizedBox(height: 12),
              HormoneChip(),
            ],
          ),
        ),
      ),
    );
  }
}
