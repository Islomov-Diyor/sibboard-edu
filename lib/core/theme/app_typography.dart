import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Nunito';

  static TextStyle get titleLarge => const TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w800,
        fontSize: 26,
        color: AppColors.text,
        height: 1.25,
      );

  static TextStyle get titleMedium => const TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: AppColors.text,
        height: 1.3,
      );

  static TextStyle get titleSmall => const TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: AppColors.text,
        height: 1.3,
      );

  static TextStyle get bodyLarge => const TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColors.text,
        height: 1.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.textSoft,
        height: 1.45,
      );

  static TextStyle get labelLarge => const TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: AppColors.text,
      );

  static TextStyle get labelMedium => const TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: AppColors.textSoft,
      );

  static TextStyle get caption => const TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: AppColors.textSoft,
      );
}
