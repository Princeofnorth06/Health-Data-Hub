import 'package:flutter/material.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new,
        size: 18,
        color: AppColors.textPrimary,
      ),
      onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
    );
  }
}
