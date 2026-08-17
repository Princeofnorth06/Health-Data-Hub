class WellnessData {
  const WellnessData({
    required this.score,
    required this.genotypeScore,
    required this.label,
    this.ranges = const [],
    this.suggestions = const [],
    this.recommendations = const [],
  });

  final double score;
  final double genotypeScore;
  final String label;
  final List<WellnessRange> ranges;
  final List<String> suggestions;
  final List<String> recommendations;
}

class WellnessRange {
  const WellnessRange({
    required this.name,
    required this.label,
    required this.description,
    required this.min,
    required this.max,
  });

  final String name;
  final String label;
  final String description;
  final double min;
  final double max;
}
