import 'package:flutter/material.dart';

class HormoneChip extends StatelessWidget {
  const HormoneChip({super.key, this.label = 'Hormone'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label));
  }
}
