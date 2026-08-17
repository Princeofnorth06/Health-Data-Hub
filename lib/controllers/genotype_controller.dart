import 'package:flutter/foundation.dart';
import 'package:health_data_hub/data/local/health_data.dart';
import 'package:health_data_hub/data/models/genetic_trait.dart';

class GenotypeController extends ChangeNotifier {
  List<GeneticTrait> _traits = HealthData.geneticTraits;

  List<GeneticTrait> get traits => List.unmodifiable(_traits);

  void updateTraits(List<GeneticTrait> traits) {
    _traits = traits;
    notifyListeners();
  }
}
