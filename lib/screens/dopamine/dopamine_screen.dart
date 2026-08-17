import 'package:flutter/material.dart';
import 'package:health_data_hub/widgets/common/app_back_button.dart';
import 'package:health_data_hub/widgets/common/section_title.dart';
import 'package:health_data_hub/widgets/gauges/dopamine_gauge.dart';

class DopamineScreen extends StatelessWidget {
  const DopamineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              SizedBox(height: 16),
              SectionTitle(title: 'Dopamine'),
              SizedBox(height: 16),
              DopamineGauge(),
            ],
          ),
        ),
      ),
    );
  }
}
