import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
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

  static const _alignments = <String, Alignment>{
    'DRD4': Alignment(-0.95, -0.58),
    'SpO2': Alignment(-0.98, 0.02),
    'COMT': Alignment(-0.92, 0.58),
    'OXTR': Alignment(0.55, -0.72),
    'SLC6A4': Alignment(0.95, -0.08),
    'OXTR_FAINT': Alignment(0.12, 0.72),
  };

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
          IgnorePointer(
            child: CustomPaint(
              size: Size.infinite,
              painter: _GeneConnectorPainter(
                alignments: [
                  _alignments['DRD4']!,
                  _alignments['COMT']!,
                  _alignments['OXTR']!,
                  _alignments['SLC6A4']!,
                ],
                selectedIndex: const ['DRD4', 'COMT', 'OXTR', 'SLC6A4']
                    .indexOf(selectedId),
              ),
            ),
          ),
          DnaVisual(height: height),
          if (drd4 != null)
            Align(
              alignment: _alignments['DRD4']!,
              child: GeneChip(
                title: drd4.name,
                subtitle: drd4.genotype,
                selected: drd4.id == selectedId,
                onTap: () => onSelect(drd4.id),
              ),
            ),
          Align(
            alignment: _alignments['SpO2']!,
            child: Spo2Chip(value: spo2),
          ),
          if (comt != null)
            Align(
              alignment: _alignments['COMT']!,
              child: GeneChip(
                title: comt.name,
                subtitle: comt.genotype,
                selected: comt.id == selectedId,
                onTap: () => onSelect(comt.id),
              ),
            ),
          if (oxtr != null) ...[
            Align(
              alignment: _alignments['OXTR']!,
              child: GeneChip(
                title: oxtr.name,
                subtitle: oxtr.genotype,
                selected: oxtr.id == selectedId,
                onTap: () => onSelect(oxtr.id),
              ),
            ),
            Align(
              alignment: _alignments['OXTR_FAINT']!,
              child: GeneChip(
                title: oxtr.name,
                subtitle: oxtr.genotype,
                faint: true,
                selected: false,
                onTap: () => onSelect(oxtr.id),
              ),
            ),
          ],
          if (slc6a4 != null)
            Align(
              alignment: _alignments['SLC6A4']!,
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

class _GeneConnectorPainter extends CustomPainter {
  _GeneConnectorPainter({
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
            ? const Color(0xFF48AF3C).withValues(alpha: 0.8)
            : AppColors.accentCyan.withValues(alpha: 0.2)
        ..strokeWidth = selected ? 1.5 : 0.8
        ..style = PaintingStyle.stroke;
      canvas.drawLine(origin, target, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GeneConnectorPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}
