import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/data/models/hormone_data.dart';

/// Genetic Strengths card matching `assets/data/wellness_overview.pdf`.
class GeneticStrengthCard extends StatelessWidget {
  const GeneticStrengthCard({super.key, required this.items});

  final List<HormoneData> items;

  static const Color _fill = Color(0xFF060C1D);
  static const Color _header = Color(0xFFA0AEC0);
  static const Color _subtitle = Color(0xFF8D9AAC);
  static const Color _divider = Color(0xFF56577A);
  static const Color _kebab = Color(0xFF5B6473);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 20),
      decoration: BoxDecoration(
        color: _fill,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Genetic Strengths', style: AppTextStyles.heading),
              ),
              const Icon(Icons.more_vert, color: _kebab, size: 20),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Highlighted areas where your genotype shows optimal performance',
            style: AppTextStyles.caption.copyWith(color: _subtitle),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Trait/Hormone',
                  style: AppTextStyles.caption.copyWith(color: _header),
                ),
              ),
              Text(
                'Score',
                style: AppTextStyles.caption.copyWith(color: _header),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _RowDivider(),
          for (final item in items) ...[
            _StrengthRow(item: item),
            const _RowDivider(),
          ],
        ],
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: GeneticStrengthCard._divider,
      child: SizedBox(width: double.infinity, height: 1),
    );
  }
}

class _StrengthRow extends StatelessWidget {
  const _StrengthRow({required this.item});

  final HormoneData item;

  @override
  Widget build(BuildContext context) {
    final progress = (item.level / 100).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: AppTextStyles.subtitle),
                    if (item.description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.description!,
                        style: AppTextStyles.strengthDetail,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _ScoreLabel(value: item.level.round()),
            ],
          ),
          const SizedBox(height: 8),
          _CyanGlowBar(progress: progress),
        ],
      ),
    );
  }
}

class _ScoreLabel extends StatelessWidget {
  const _ScoreLabel({required this.value});

  final int value;

  static const Color _glow = Color(0xFF0075FF);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$value%',
      style: AppTextStyles.scoreValue.copyWith(
        shadows: [
          Shadow(
            color: _glow.withValues(alpha: 0.95),
            blurRadius: 10,
            offset: const Offset(0, 8),
          ),
          Shadow(
            color: _glow.withValues(alpha: 0.55),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
    );
  }
}

class _CyanGlowBar extends StatelessWidget {
  const _CyanGlowBar({required this.progress});

  final double progress;

  static const Color _fill = Color(0xFF01B0E2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: progress,
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              color: _fill,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: _fill.withValues(alpha: 0.9),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: const Color(0xFF0075FF).withValues(alpha: 0.4),
                  blurRadius: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
