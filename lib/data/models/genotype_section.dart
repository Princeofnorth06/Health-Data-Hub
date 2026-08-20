class GenotypeSection {
  const GenotypeSection({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  static const String hormoneRegulation = 'hormoneRegulation';
  static const String overallWellness = 'overallWellness';

  static const List<GenotypeSection> catalog = [
    GenotypeSection(
      id: hormoneRegulation,
      title: 'Hormone Regulation Score',
      subtitle: "Your body's genetic tendency for hormone balance.",
      icon: GenotypeSectionIcon.molecule,
    ),
    GenotypeSection(
      id: overallWellness,
      title: 'Overall Wellness Profile',
      subtitle: 'Your genetic snapshot of overall health.',
      icon: GenotypeSectionIcon.heartPulse,
    ),
  ];

  final String id;
  final String title;
  final String subtitle;
  final GenotypeSectionIcon icon;
}

enum GenotypeSectionIcon { molecule, heartPulse }
