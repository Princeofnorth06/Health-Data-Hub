import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_data_hub/app/bindings/initial_binding.dart';
import 'package:health_data_hub/app/routes/app_routes.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/app/theme/app_theme.dart';
import 'package:health_data_hub/core/constants/app_constants.dart';
import 'package:health_data_hub/screens/dopamine/dopamine_screen.dart';
import 'package:health_data_hub/screens/genotype/genotype_screen.dart';
import 'package:health_data_hub/screens/wellness/wellness_heart_score_screen.dart';
import 'package:health_data_hub/screens/wellness/wellness_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTextStyles.ensureLoaded();
  runApp(const HealthDataHubApp());
}

class HealthDataHubApp extends StatelessWidget {
  const HealthDataHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.wellness,
      getPages: [
        GetPage(name: AppRoutes.wellness, page: () => const WellnessScreen()),
        GetPage(
          name: AppRoutes.heartScore,
          page: () => const WellnessHeartScoreScreen(),
        ),
        GetPage(name: AppRoutes.genotype, page: () => const GenotypeScreen()),
        GetPage(name: AppRoutes.dopamine, page: () => const DopamineScreen()),
      ],
    );
  }
}
