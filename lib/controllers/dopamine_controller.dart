import 'package:flutter/foundation.dart';
import 'package:health_data_hub/data/local/health_data.dart';
import 'package:health_data_hub/data/models/hormone_data.dart';

class DopamineController extends ChangeNotifier {
  List<HormoneData> _hormones = HealthData.hormones;

  List<HormoneData> get hormones => List.unmodifiable(_hormones);

  void updateHormones(List<HormoneData> hormones) {
    _hormones = hormones;
    notifyListeners();
  }
}
