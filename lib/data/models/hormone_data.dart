class HormoneData {
  const HormoneData({
    required this.name,
    required this.level,
    this.description,
    this.unit,
  });

  final String name;
  final double level;
  final String? description;
  final String? unit;
}
