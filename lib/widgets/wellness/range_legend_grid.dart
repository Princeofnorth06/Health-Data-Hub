import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/data/models/wellness_data.dart';
import 'package:health_data_hub/widgets/common/section_title.dart';

/// Two-column range legend matching the Wellness / Dopamine PDF RANGES block.
class RangeLegendGrid extends StatelessWidget {
  const RangeLegendGrid({super.key, required this.ranges});

  final List<WellnessRange> ranges;

  static const double _headingGap = 22;
  static const double _rowGap = 18;
  static const double _columnGutter = 12;

  @override
  Widget build(BuildContext context) {
    if (ranges.isEmpty) {
      return const SizedBox.shrink();
    }

    final row1 = ranges.take(2).toList();
    final row2 = ranges.skip(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'RANGES'),
        const SizedBox(height: _headingGap),
        _LegendRow(items: row1, gutter: _columnGutter),
        if (row2.isNotEmpty) ...[
          const SizedBox(height: _rowGap),
          _LegendRow(items: row2, gutter: _columnGutter, fillEmptyColumn: true),
        ],
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.items,
    required this.gutter,
    this.fillEmptyColumn = false,
  });

  final List<WellnessRange> items;
  final double gutter;
  final bool fillEmptyColumn;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) SizedBox(width: gutter),
          Expanded(child: _RangeLegendCell(range: items[i])),
        ],
        if (fillEmptyColumn && items.length == 1) ...[
          SizedBox(width: gutter),
          const Expanded(child: SizedBox.shrink()),
        ],
      ],
    );
  }
}

class _RangeLegendCell extends StatelessWidget {
  const _RangeLegendCell({required this.range});

  final WellnessRange range;

  static const Color _high = Color(0xFF48AF3C);
  static const Color _moderate = Color(0xFFFEDC11);
  static const Color _low = Color(0xFFFE4C11);

  static const double _swatchSize = 25;
  static const double _swatchRadius = 6;
  static const double _titleToBody = 6;
  static const double _swatchToText = 12;

  Color get _color {
    switch (range.name) {
      case 'High':
        return _high;
      case 'Moderate':
        return _moderate;
      default:
        return _low;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${range.name} (${range.label})',
          style: AppTextStyles.rangeLabel,
        ),
        const SizedBox(height: _titleToBody),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: _swatchSize,
              height: _swatchSize,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(_swatchRadius),
                boxShadow: [
                  BoxShadow(
                    color: _color.withValues(alpha: 0.55),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: _swatchToText),
            Expanded(
              child: Text(range.description, style: AppTextStyles.caption),
            ),
          ],
        ),
      ],
    );
  }
}
