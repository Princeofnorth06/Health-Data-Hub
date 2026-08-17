class WellnessData {
  const WellnessData({
    required this.score,
    required this.label,
    this.ranges = const [],
  });

  final double score;
  final String label;
  final List<WellnessRange> ranges;
}

class WellnessRange {
  const WellnessRange({
    required this.name,
    required this.min,
    required this.max,
    required this.value,
  });

  final String name;
  final double min;
  final double max;
  final double value;
}
