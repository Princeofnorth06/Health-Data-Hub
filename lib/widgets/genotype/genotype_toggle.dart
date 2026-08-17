import 'package:flutter/material.dart';

class GenotypeToggle extends StatelessWidget {
  const GenotypeToggle({super.key, this.value = false, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(value: value, onChanged: onChanged);
  }
}
