class GeneticTrait {
  const GeneticTrait({
    required this.id,
    required this.name,
    required this.genotype,
    this.description,
  });

  final String id;
  final String name;
  final String genotype;
  final String? description;
}
