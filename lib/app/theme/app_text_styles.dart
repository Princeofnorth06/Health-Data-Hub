import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';

/// Two type roles:
/// - Display → Orbitron (futuristic geometric headings)
/// - Body → Inter (clean readable sans-serif)
class AppTextStyles {
  AppTextStyles._();

  static String get displayFamily => GoogleFonts.orbitron().fontFamily!;
  static String get bodyFamily => GoogleFonts.inter().fontFamily!;

  static Future<void> ensureLoaded() {
    return GoogleFonts.pendingFonts([
      GoogleFonts.orbitron(),
      GoogleFonts.inter(),
    ]);
  }

  // --- Display (Orbitron) ---

  static final TextStyle screenTitle = GoogleFonts.orbitron(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.8,
    height: 1.2,
  );

  static final TextStyle displayMedium = GoogleFonts.orbitron(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.4,
    height: 1.2,
  );

  static final TextStyle heading = GoogleFonts.orbitron(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
    height: 1.25,
  );

  static final TextStyle sectionTitle = GoogleFonts.orbitron(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 2.0,
    height: 1.2,
  );

  // --- Body (Inter) ---

  static final TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.35,
    letterSpacing: 0,
  );

  static final TextStyle rangeLabel = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: 0,
  );

  static final TextStyle body = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.45,
    letterSpacing: 0,
  );

  static final TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.45,
    letterSpacing: 0,
  );

  static final TextStyle strengthDetail = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.accentBlue,
    height: 1.35,
    letterSpacing: 0,
  );

  static final TextStyle scoreValue = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: 0,
  );

  static final TextStyle gaugeScore = GoogleFonts.inter(
    fontSize: 42,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.0,
    letterSpacing: -0.5,
  );

  static final TextStyle gaugeLabel = GoogleFonts.orbitron(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: const Color(0xFFB8B8B8),
    height: 1.0,
    letterSpacing: 0.1,
  );

  static final TextStyle toggleLabel = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: 0.2,
  );

  static final TextStyle chipLabel = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: 0.2,
  );

  static final TextStyle aboutLabel = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: 0,
  );

  /// Alias used by a few widgets for trait names / medium body labels.
  static TextStyle get subtitle => bodyLarge;
}
