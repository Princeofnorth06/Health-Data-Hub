import 'package:health_data_hub/data/models/genetic_trait.dart';
import 'package:health_data_hub/data/models/hormone_data.dart';
import 'package:health_data_hub/data/models/wellness_data.dart';

class HealthData {
  HealthData._();

  static const WellnessData wellness = WellnessData(
    score: 0,
    label: 'Baseline',
  );

  static const List<GeneticTrait> geneticTraits = [];

  static const List<HormoneData> hormones = [];
}
