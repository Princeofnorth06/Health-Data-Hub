import 'package:get/get.dart';
import 'package:health_data_hub/data/local/health_data.dart';
import 'package:health_data_hub/data/models/heart_score_data.dart';
import 'package:health_data_hub/data/models/hormone_data.dart';
import 'package:health_data_hub/data/models/wellness_data.dart';

class WellnessController extends GetxController {
  final WellnessData wellness = HealthData.wellness;
  final List<HormoneData> strengths = HealthData.hormones;
  final HeartScoreData heartScore = HealthData.heartScore;
}
