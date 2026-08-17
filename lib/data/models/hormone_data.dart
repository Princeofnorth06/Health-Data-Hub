class HormoneData {
  const HormoneData({
    required this.name,
    required this.level,
    this.description,
    this.unit,
    this.subtitle,
    this.interpretation,
    this.about,
    this.aboutVariations = const [],
  });

  final String name;
  final double level;
  final String? description;
  final String? unit;
  final String? subtitle;
  final String? interpretation;
  final String? about;
  final List<HormoneToneVariation> aboutVariations;

  bool get hasDetail => interpretation != null && interpretation!.isNotEmpty;

  String get fullTitle {
    if (subtitle == null || subtitle!.isEmpty) {
      return name;
    }
    return '$name ($subtitle)';
  }
}

class HormoneToneVariation {
  const HormoneToneVariation({
    required this.label,
    required this.text,
  });

  final String label;
  final String text;
}
