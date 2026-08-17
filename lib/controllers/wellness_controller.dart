import 'package:flutter/foundation.dart';
import 'package:health_data_hub/data/local/health_data.dart';
import 'package:health_data_hub/data/models/wellness_data.dart';

class WellnessController extends ChangeNotifier {
  WellnessData _data = HealthData.wellness;

  WellnessData get data => _data;

  void update(WellnessData data) {
    _data = data;
    notifyListeners();
  }
}
