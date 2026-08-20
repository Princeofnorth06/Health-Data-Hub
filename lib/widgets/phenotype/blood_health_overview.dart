import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/data/models/blood_quality.dart';

class BloodHealthOverview extends StatelessWidget {
  const BloodHealthOverview({super.key, required this.data});

  final BloodQuality data;

  static const Color _glow = Color(0xFF12708B);
  static const Color _rim = Color(0xFF1B8CA8);
  static const Color _divider = Color(0xFF2A3344);
  static const Color _optimal = Color(0xFF48AF3C);
  static const Color _moderate = Color(0xFFFEDC11);
  static const Color _low = Color(0xFFFE4C11);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _glow.withValues(alpha: 0.55),
            blurRadius: 18,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: const Color(0xFF00C8FF).withValues(alpha: 0.14),
            blurRadius: 24,
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
        decoration: BoxDecoration(
          color: const Color(0xFF000000),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _rim, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.overviewTitle, style: AppTextStyles.heading),
            const SizedBox(height: 8),
            Text(data.overviewSubtitle, style: AppTextStyles.caption),
            const SizedBox(height: 16),
            const _TableHeader(),
            const SizedBox(height: 8),
            const _RowDivider(),
            for (final row in data.metrics) ...[
              _MetricRow(row: row),
              const _RowDivider(),
            ],
          ],
        ),
      ),
    );
  }

  static Color statusColor(String status) {
    switch (status) {
      case 'Optimal':
        return _optimal;
      case 'Moderate':
        return _moderate;
      default:
        return _low;
    }
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.caption.copyWith(
      fontSize: 9,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w600,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: Text('METRICS', style: style)),
        Expanded(flex: 3, child: Text('VALUES', style: style)),
        Expanded(flex: 3, child: Text('HEALTHY RANGE', style: style)),
        SizedBox(
          width: 72,
          child: Text('STATUS', style: style, textAlign: TextAlign.right),
        ),
      ],
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.row});

  final BloodMetricRow row;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(row.name, style: AppTextStyles.aboutLabel),
                const SizedBox(height: 6),
                Text(
                  row.description,
                  style: AppTextStyles.caption.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.value,
              style: AppTextStyles.chipLabel.copyWith(fontSize: 11),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.healthyRange,
              style: AppTextStyles.caption.copyWith(fontSize: 10),
            ),
          ),
          SizedBox(
            width: 72,
            child: Align(
              alignment: Alignment.topRight,
              child: _StatusPill(status: row.status),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = BloodHealthOverview.statusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.85)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 8,
          ),
        ],
      ),
      child: Text(
        status,
        style: AppTextStyles.chipLabel.copyWith(
          color: color,
          fontSize: 9,
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: BloodHealthOverview._divider,
      child: SizedBox(width: double.infinity, height: 1),
    );
  }
}
