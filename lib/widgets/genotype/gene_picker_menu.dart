import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/controllers/genotype_controller.dart';
import 'package:health_data_hub/core/constants/app_assets.dart';
import 'package:health_data_hub/data/models/genetic_trait.dart';
import 'package:health_data_hub/widgets/genotype/section_selector.dart';

class GenePickerAnchor extends StatelessWidget {
  const GenePickerAnchor({
    super.key,
    required this.controller,
    required this.gene,
  });

  final GenotypeController controller;
  final GeneticTrait gene;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => SectionSelector(
            title: '${gene.name} Genotype Score',
            expanded: controller.isGeneMenuOpen.value,
            onTap: controller.toggleGeneMenu,
          ),
        ),
        Obx(() {
          if (!controller.isGeneMenuOpen.value) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: GenePickerMenu(
              genes: controller.pickerGenes,
              selectedId: controller.selectedGeneId.value,
              onSelect: controller.selectGene,
            ),
          );
        }),
      ],
    );
  }
}

class GenePickerMenu extends StatelessWidget {
  const GenePickerMenu({
    super.key,
    required this.genes,
    required this.selectedId,
    required this.onSelect,
  });

  final List<GeneticTrait> genes;
  final String selectedId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xF214141C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textPrimary.withValues(alpha: 0.22),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5B3A9A).withValues(alpha: 0.28),
            blurRadius: 24,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < genes.length; i++) ...[
            if (i > 0) const SizedBox(height: 8),
            _GenePickerRow(
              gene: genes[i],
              selected: genes[i].id == selectedId,
              onTap: () => onSelect(genes[i].id),
            ),
          ],
        ],
      ),
    );
  }
}

class _GenePickerRow extends StatelessWidget {
  const _GenePickerRow({
    required this.gene,
    required this.selected,
    required this.onTap,
  });

  final GeneticTrait gene;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = Color(gene.accent);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 12, 12, 12),
        decoration: BoxDecoration(
          color: const Color(0xE6121218),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? accent.withValues(alpha: 0.7)
                : AppColors.textPrimary.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A22),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(accent, BlendMode.srcATop),
                    child: Image.asset(
                      AppAssets.dnaHelix,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                if (selected)
                  Positioned(
                    top: -3,
                    left: -3,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: accent.withValues(alpha: 0.7),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(gene.fullTitle, style: AppTextStyles.bodyLarge),
                  const SizedBox(height: 4),
                  Text(
                    gene.menuSubtitle ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
