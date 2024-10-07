import 'package:flutter/material.dart';
import 'package:weather_wise/constants/app_colors.dart';

class AppStyles {
  // we define the text and style of the app

  // text style

  static const h1 = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const h2 = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const h3 =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  static const bigtext = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const subtitleText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  static const largeSubtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );
}
