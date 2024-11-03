import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wheater_app/screen/utils/constants/colors.dart';

class ElevatedButtonThemes {
  ElevatedButtonThemes._();

  static final ElevatedButtonThemeData lightElevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.darkTextPrimary,
      backgroundColor: AppColors.dark,
      disabledForegroundColor: AppColors.dark,
      disabledBackgroundColor: AppColors.dark,
      padding: const EdgeInsets.symmetric(vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),
    ),
  );

  static final ElevatedButtonThemeData darkElevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.darkTextPrimary,
      backgroundColor: AppColors.lightSecondary,
      disabledForegroundColor: AppColors.lightSecondary,
      disabledBackgroundColor: AppColors.lightSecondary,
      padding: const EdgeInsets.symmetric(vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),
    ),
  );
}
