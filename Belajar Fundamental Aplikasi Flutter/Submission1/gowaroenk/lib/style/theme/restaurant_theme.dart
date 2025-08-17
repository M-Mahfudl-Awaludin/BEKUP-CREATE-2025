import 'package:flutter/material.dart';

class RestaurantColors {
  static const primary = Color(0xFF00BFA6); // hijau toska modern
  static const secondary = Color(0xFFFF7043); // oranye hangat
  static const backgroundLight = Color(0xFFF9F9F9);
  static const backgroundDark = Color(0xFF121212);
}

class RestaurantTextStyles {
  static const displayLarge = TextStyle(fontSize: 36, fontWeight: FontWeight.bold);
  static const displayMedium = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
  static const displaySmall = TextStyle(fontSize: 28, fontWeight: FontWeight.w600);

  static const headlineLarge = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static const headlineMedium = TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  static const headlineSmall = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);

  static const titleLarge = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const titleMedium = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const titleSmall = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  static const bodyLargeBold = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const bodyLargeMedium = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const bodyLargeRegular = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  static const labelLarge = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static const labelMedium = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  static const labelSmall = TextStyle(fontSize: 11, fontWeight: FontWeight.w500);
}

class RestaurantTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: RestaurantColors.primary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: RestaurantColors.backgroundLight,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: RestaurantColors.primary,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: RestaurantColors.backgroundDark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: RestaurantTextStyles.displayLarge,
      displayMedium: RestaurantTextStyles.displayMedium,
      displaySmall: RestaurantTextStyles.displaySmall,
      headlineLarge: RestaurantTextStyles.headlineLarge,
      headlineMedium: RestaurantTextStyles.headlineMedium,
      headlineSmall: RestaurantTextStyles.headlineSmall,
      titleLarge: RestaurantTextStyles.titleLarge,
      titleMedium: RestaurantTextStyles.titleMedium,
      titleSmall: RestaurantTextStyles.titleSmall,
      bodyLarge: RestaurantTextStyles.bodyLargeBold,
      bodyMedium: RestaurantTextStyles.bodyLargeMedium,
      bodySmall: RestaurantTextStyles.bodyLargeRegular,
      labelLarge: RestaurantTextStyles.labelLarge,
      labelMedium: RestaurantTextStyles.labelMedium,
      labelSmall: RestaurantTextStyles.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      elevation: 2,
      backgroundColor: RestaurantColors.primary,
      foregroundColor: Colors.white,
      toolbarTextStyle: _textTheme.titleLarge?.copyWith(color: Colors.white),
      titleTextStyle: _textTheme.titleLarge?.copyWith(color: Colors.white),
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
    );
  }
}
