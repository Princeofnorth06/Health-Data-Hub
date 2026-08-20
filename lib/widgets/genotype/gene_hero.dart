import 'package:flutter/material.dart';
import 'package:health_data_hub/data/models/genetic_trait.dart';
import 'package:health_data_hub/widgets/genotype/dna_visual.dart';
import 'package:health_data_hub/widgets/genotype/gene_chip.dart';

class GeneHero extends StatelessWidget {
  const GeneHero({
    super.key,
    required this.height,
    required this.genes,
    required this.selectedId,
    required this.spo2,
    required this.onSelect,
  });

  final double height;
  final List<GeneticTrait> genes;
  final String selectedId;
  final double spo2;
  final ValueChanged<String> onSelect;

  GeneticTrait? _gene(String id) {
    for (final gene in genes) {
      if (gene.id == id) {
        return gene;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final drd4 = _gene('DRD4');
    final slc6a4 = _gene('SLC6A4');
    final comt = _gene('COMT');
    final oxtr = _gene('OXTR');

    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          DnaVisual(height: height),
          if (drd4 != null)
            Align(
              alignment: const Alignment(-0.95, -0.58),
              child: GeneChip(
                title: drd4.name,
                subtitle: drd4.genotype,
                selected: drd4.id == selectedId,
                onTap: () => onSelect(drd4.id),
              ),
            ),
          Align(
            alignment: const Alignment(-0.98, 0.02),
            child: Spo2Chip(value: spo2),
          ),
          if (comt != null)
            Align(
              alignment: const Alignment(-0.92, 0.58),
              child: GeneChip(
                title: comt.name,
                subtitle: comt.genotype,
                selected: comt.id == selectedId,
                onTap: () => onSelect(comt.id),
              ),
            ),
          if (oxtr != null)
            Align(
              alignment: const Alignment(0.55, -0.72),
              child: GeneChip(
                title: oxtr.name,
                subtitle: oxtr.genotype,
                selected: oxtr.id == selectedId,
                onTap: () => onSelect(oxtr.id),
              ),
            ),
          if (slc6a4 != null)
            Align(
              alignment: const Alignment(0.95, -0.08),
              child: GeneChip(
                title: slc6a4.name,
                subtitle: slc6a4.genotype,
                selected: slc6a4.id == selectedId,
                onTap: () => onSelect(slc6a4.id),
              ),
            ),
        ],
      ),
    );
  }
}
