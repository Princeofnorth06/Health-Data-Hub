class HeartScoreData {
  const HeartScoreData({
    required this.score,
    required this.status,
    required this.badgeLabel,
    required this.badgeValue,
    required this.ranges,
    required this.parametersIntro,
    required this.parameters,
    required this.about,
  });

  final double score;
  final String status;
  final String badgeLabel;
  final double badgeValue;
  final List<HeartRange> ranges;
  final String parametersIntro;
  final List<HeartParameter> parameters;
  final String about;
}

class HeartRange {
  const HeartRange({
    required this.value,
    required this.label,
    required this.tone,
  });

  final String value;
  final String label;
  final String tone;
}

class HeartParameter {
  const HeartParameter({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}
