class GeneticTrait {
  const GeneticTrait({
    required this.id,
    required this.name,
    required this.genotype,
    this.description,
    this.score = 0,
    this.interpretation,
    this.about,
    this.menuSubtitle,
    this.strengths = const [],
    this.weaknesses = const [],
  });

  final String id;
  final String name;
  final String genotype;
  final String? description;
  final double score;
  final String? interpretation;
  final String? about;
  final String? menuSubtitle;
  final List<OrganScore> strengths;
  final List<OrganScore> weaknesses;

  bool get hasScore => score > 0;

  bool get hasOrganwise => strengths.isNotEmpty || weaknesses.isNotEmpty;

  String get fullTitle {
    if (genotype.isEmpty) {
      return name;
    }
    return '$name ($genotype)';
  }

  static const List<GeneticTrait> catalog = [
    GeneticTrait(
      id: 'DRD4',
      name: 'DRD4',
      genotype: 'Dopamine Receptor D4',
    ),
    GeneticTrait(
      id: 'SLC6A4',
      name: 'SLC6A4',
      genotype: 'Serotonin Transporter Gene',
      score: 66,
      menuSubtitle: 'anxiety and emotional regulation.',
      interpretation:
          'Your SLC6A4 genotype score of 66% indicates a moderate '
          'efficiency in serotonin transport. This gene plays a vital '
          'role in regulating serotonin levels in the brain, influencing '
          'mood, emotional balance, and how you respond to stress.\n\n'
          'A moderate score suggests that while your serotonin system is '
          'functional, you may experience mild sensitivity to stress or '
          'fluctuating moods under challenging circumstances. Supporting '
          'your mental wellness through stress management techniques, '
          'mindfulness, and a balanced lifestyle can help optimize your '
          'serotonin function.',
      about:
          'SLC6A4 is a gene that encodes the serotonin transporter '
          'protein. This protein helps transport serotonin (a '
          'neurotransmitter known as the \'feel-good chemical\') from '
          'the spaces between nerve cells back into the cells. The '
          'SLC6A4 gene plays an important role in mood regulation, '
          'stress response, and emotional well-being.',
      strengths: [
        OrganScore(label: 'Heart', value: 76.96, id: 'heart'),
        OrganScore(label: 'kidney', value: 89.77),
        OrganScore(label: 'Brain', value: 8.78),
        OrganScore(label: 'intestine', value: 72.22),
        OrganScore(label: 'HCV Antibody', value: 88.05),
      ],
      weaknesses: [
        OrganScore(label: 'Teeth', value: 23.05),
        OrganScore(label: 'Skin', value: 34.05),
        OrganScore(label: 'Eyes', value: 59.05),
        OrganScore(label: 'HCV Antibody', value: 22.05),
      ],
    ),
    GeneticTrait(
      id: 'COMT',
      name: 'COMT',
      genotype: 'Catechol-O-Methyltransferase',
      menuSubtitle:
          'cognitive functions like memory and decision-making, linked to executive.',
    ),
    GeneticTrait(
      id: 'OXTR',
      name: 'OXTR',
      genotype: 'Oxytocin Receptor Gene',
      menuSubtitle: 'social behavior, empathy, and stress response.',
    ),
    GeneticTrait(
      id: 'MAOA',
      name: 'MAOA',
      genotype: 'Monoamine Oxidase A',
      menuSubtitle: 'aggression, impulse control, and emotional regulation.',
    ),
  ];
}

class OrganScore {
  const OrganScore({
    required this.label,
    required this.value,
    this.id,
  });

  final String label;
  final double value;
  final String? id;
}
