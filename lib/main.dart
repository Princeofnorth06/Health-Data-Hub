import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_data_hub/app/bindings/initial_binding.dart';
import 'package:health_data_hub/app/routes/app_routes.dart';
import 'package:health_data_hub/app/theme/app_theme.dart';
import 'package:health_data_hub/core/constants/app_constants.dart';
import 'package:health_data_hub/screens/dopamine/dopamine_screen.dart';
import 'package:health_data_hub/screens/genotype/genotype_screen.dart';
import 'package:health_data_hub/screens/wellness/wellness_screen.dart';

void main() {
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
      routes: {
        AppRoutes.wellness: (_) => const WellnessScreen(),
        AppRoutes.genotype: (_) => const GenotypeScreen(),
        AppRoutes.dopamine: (_) => const DopamineScreen(),
      },
    );
  }
}
