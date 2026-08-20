import 'package:get/get.dart';
import 'package:health_data_hub/data/local/health_data.dart';
import 'package:health_data_hub/data/models/blood_metrics.dart';
import 'package:health_data_hub/data/models/genetic_trait.dart';
import 'package:health_data_hub/data/models/genotype_section.dart';
import 'package:health_data_hub/data/models/hormone_data.dart';
import 'package:health_data_hub/data/models/wellness_data.dart';

class GenotypeController extends GetxController {
  final hormones = HealthData.hormoneRegulation;
  final ranges = HealthData.wellness.ranges;
  final sections = GenotypeSection.catalog;
  final genes = GeneticTrait.catalog;

  static const double spo2Percent = 98;

  final isGenotypeSelected = true.obs;
  final selectedHormoneName = 'Dopamine'.obs;
  final isSectionMenuOpen = false.obs;
  final isGeneMenuOpen = false.obs;
  final isMetricMenuOpen = false.obs;
  final selectedSectionId = GenotypeSection.hormoneRegulation.obs;
  final selectedGeneId = 'SLC6A4'.obs;
  final selectedPhenotypeMetric = PhenotypeMetric.blood.obs;

  HormoneData get selectedHormone {
    return hormones.firstWhere(
      (hormone) => hormone.name == selectedHormoneName.value,
      orElse: () => hormones.first,
    );
  }

  GeneticTrait get selectedGene {
    return genes.firstWhere(
      (gene) => gene.id == selectedGeneId.value,
      orElse: () => genes.first,
    );
  }

  GenotypeSection get selectedSection {
    return sections.firstWhere(
      (section) => section.id == selectedSectionId.value,
      orElse: () => sections.first,
    );
  }

  bool get isHormoneSection {
    return selectedSectionId.value == GenotypeSection.hormoneRegulation;
  }

  String get sectionTitle => selectedSection.selectorTitle;

  void selectHormone(String name) {
    selectedHormoneName.value = name;
  }

  void selectGene(String id) {
    selectedGeneId.value = id;
    isGeneMenuOpen.value = false;
  }

  List<GeneticTrait> get pickerGenes {
    return genes.where((gene) => gene.inPicker).toList();
  }

  void selectGenotypeTab(bool selected) {
    isGenotypeSelected.value = selected;
    isSectionMenuOpen.value = false;
    isGeneMenuOpen.value = false;
    isMetricMenuOpen.value = false;
  }

  void toggleMetricMenu() {
    isMetricMenuOpen.toggle();
  }

  void selectPhenotypeMetric(String id) {
    selectedPhenotypeMetric.value = id;
    isMetricMenuOpen.value = false;
  }

  void openSectionMenu() {
    isSectionMenuOpen.value = true;
  }

  void toggleSectionMenu() {
    isGeneMenuOpen.value = false;
    isSectionMenuOpen.toggle();
  }

  void closeSectionMenu() {
    isSectionMenuOpen.value = false;
  }

  void toggleGeneMenu() {
    isSectionMenuOpen.value = false;
    isGeneMenuOpen.toggle();
  }

  void closeGeneMenu() {
    isGeneMenuOpen.value = false;
  }

  void selectSection(String id) {
    selectedSectionId.value = id;
    isSectionMenuOpen.value = false;
    isGeneMenuOpen.value = false;
  }

  List<WellnessRange> get scoreRanges => ranges;
}
