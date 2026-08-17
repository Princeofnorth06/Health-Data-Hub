import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({super.key, this.title = 'Recommendation'});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(title, style: AppTextStyles.subtitle),
      ),
    );
  }
}
