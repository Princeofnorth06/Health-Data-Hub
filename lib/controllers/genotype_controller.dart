import 'package:get/get.dart';
import 'package:health_data_hub/data/local/health_data.dart';
import 'package:health_data_hub/data/models/hormone_data.dart';
import 'package:health_data_hub/data/models/wellness_data.dart';

class GenotypeController extends GetxController {
  final hormones = HealthData.hormoneRegulation;
  final ranges = HealthData.wellness.ranges;
  final sectionTitle = 'Hormone Regulation Score';

  final isGenotypeSelected = true.obs;
  final selectedHormoneName = 'Dopamine'.obs;

  HormoneData get selectedHormone {
    return hormones.firstWhere(
      (hormone) => hormone.name == selectedHormoneName.value,
      orElse: () => hormones.first,
    );
  }

  void selectHormone(String name) {
    selectedHormoneName.value = name;
  }

  void selectGenotypeTab(bool selected) {
    isGenotypeSelected.value = selected;
  }

  List<WellnessRange> get scoreRanges => ranges;
}
