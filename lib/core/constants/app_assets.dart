class AppAssets {
  AppAssets._();

  static const String _images = 'assets/images';

  // Organs
  static const String bladder = '$_images/organs/bladder.png';
  static const String brain = '$_images/organs/brain.png';
  static const String femaleReproductiveSystem =
      '$_images/organs/female_reproductive_system.png';
  static const String heart = '$_images/organs/heart.png';
  static const String intestine = '$_images/organs/intestine.png';
  static const String kidney = '$_images/organs/kidney.png';
  static const String liver = '$_images/organs/liver.png';
  static const String liver1 = '$_images/organs/liver_1.png';
  static const String lungs = '$_images/organs/lungs.png';
  static const String spine = '$_images/organs/spine.png';
  static const String stomach = '$_images/organs/stomach.png';
  static const String thymusGland = '$_images/organs/thymus_gland.png';

  // Genotype / DNA
  static const String dnaHelix = '$_images/genotype/dna_helix.png';
  static const String dnaHelix1 = '$_images/genotype/dna_helix_1.png';
  static const String dnaHero = '$_images/genotype/dna_hero.png';
  static const String dnaHero1 = '$_images/genotype/dna_hero_1.png';

  // Icons
  static const String metricSelector = '$_images/icons/metric_selector.png';

  // Decorative / gauges
  static const String gaugeGreen = '$_images/decorative/gauge_green.png';
  static const String gaugeYellow = '$_images/decorative/gauge_yellow.png';
  static const String redBloodCells = '$_images/decorative/red_blood_cells.png';

  // Design mockups (PNG screen exports)
  static const String mockupWellnessHeartScore =
      '$_images/mockups/wellness_heart_score.png';
  static const String mockupWellnessOverview =
      '$_images/mockups/wellness_overview.png';
  static const String mockupGenotypeDopamine =
      '$_images/mockups/genotype_dopamine.png';
  static const String mockupPhenotypeBloodMetrics =
      '$_images/mockups/phenotype_blood_metrics.png';
  static const String mockupGenotypeOrganwise =
      '$_images/mockups/genotype_organwise.png';
  static const String mockupGenotypeSlc6a4 =
      '$_images/mockups/genotype_slc6a4.png';
  static const String mockupGenotypeHormone =
      '$_images/mockups/genotype_hormone.png';
  static const String mockupGenotypeGeneCarousel =
      '$_images/mockups/genotype_gene_carousel.png';
  static const String mockupPhenotypeBloodQuality =
      '$_images/mockups/phenotype_blood_quality.png';

  static const List<String> organs = [
    bladder,
    brain,
    femaleReproductiveSystem,
    heart,
    intestine,
    kidney,
    liver,
    liver1,
    lungs,
    spine,
    stomach,
    thymusGland,
  ];

  static const List<String> genotype = [
    dnaHelix,
    dnaHelix1,
    dnaHero,
    dnaHero1,
  ];

  static const List<String> all = [
    ...organs,
    ...genotype,
    metricSelector,
    gaugeGreen,
    gaugeYellow,
    redBloodCells,
    mockupWellnessHeartScore,
    mockupWellnessOverview,
    mockupGenotypeDopamine,
    mockupPhenotypeBloodMetrics,
    mockupGenotypeOrganwise,
    mockupGenotypeSlc6a4,
    mockupGenotypeHormone,
    mockupGenotypeGeneCarousel,
    mockupPhenotypeBloodQuality,
  ];
}
