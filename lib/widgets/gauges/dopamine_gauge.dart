import 'package:flutter/material.dart';

class DopamineGauge extends StatelessWidget {
  const DopamineGauge({super.key, this.value = 0});

  final double value;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: value.clamp(0, 1));
  }
}
