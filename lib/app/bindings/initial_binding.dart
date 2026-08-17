import 'package:get/get.dart';
import 'package:health_data_hub/controllers/dopamine_controller.dart';
import 'package:health_data_hub/controllers/genotype_controller.dart';
import 'package:health_data_hub/controllers/wellness_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WellnessController(), permanent: true);
    Get.put(GenotypeController(), permanent: true);
    Get.put(DopamineController(), permanent: true);
  }
}
