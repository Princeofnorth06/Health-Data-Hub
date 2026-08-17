class HormoneData {
  const HormoneData({
    required this.name,
    required this.level,
    this.unit,
  });

  final String name;
  final double level;
  final String? unit;
}
