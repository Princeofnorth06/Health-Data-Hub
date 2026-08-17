import 'package:flutter/material.dart';

class WellnessGauge extends StatelessWidget {
  const WellnessGauge({super.key, this.value = 0});

  final double value;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: value.clamp(0, 1));
  }
}
