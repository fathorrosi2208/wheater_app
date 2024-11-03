import 'package:flutter/material.dart';
import 'package:wheater_app/screen/utils/constants/colors.dart';

class CardThemes {
  CardThemes._();

  static CardTheme lightThemeData = const CardTheme(
    color: AppColors.lightSecondary,
    elevation: 0,
  );

  static CardTheme darkThemeData = const CardTheme(
    color: AppColors.darkSecondary,
    elevation: 0,
  );
}
