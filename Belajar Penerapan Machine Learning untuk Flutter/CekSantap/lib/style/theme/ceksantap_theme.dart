import 'package:flutter/material.dart';
import 'package:ceksantap/style/typography/ceksantap_text_styles.dart';

class CeksantapColors {
  static const Color primary = Color(0xFFE67514);
  static const Color secondary = Color(0xFF212121);
  static const Color secondaryGreen = Color(0xFF06923E);
  static const Color paleGreen = Color(0xFFD3ECCD);
  static const Color lightGreen  = Color(0xFFB4E50D);
  static const Color darkGreen  = Color(0xFF78C841);
  static const Color backgroundLight = Color(0xFFF9F9F9);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color darkGrey = Color(0xFF616161);

}

class CeksantapTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: CeksantapColors.primary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: CeksantapColors.backgroundLight,
      textTheme: _lightTextTheme,
      tabBarTheme: _lightTabBarTheme,
      bottomNavigationBarTheme: _lightBottomNavTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: CeksantapColors.primary,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: CeksantapColors.backgroundDark,
      textTheme: _darkTextTheme,
      tabBarTheme: _darkTabBarTheme,
      bottomNavigationBarTheme: _darkBottomNavTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: CeksantapTextStyles.displayLarge,
      displayMedium: CeksantapTextStyles.displayMedium,
      displaySmall: CeksantapTextStyles.displaySmall,
      headlineLarge: CeksantapTextStyles.headlineLarge,
      headlineMedium: CeksantapTextStyles.headlineMedium,
      headlineSmall: CeksantapTextStyles.headlineSmall,
      titleLarge: CeksantapTextStyles.titleLarge,
      titleMedium: CeksantapTextStyles.titleMedium,
      titleSmall: CeksantapTextStyles.titleSmall,
      bodyLarge: CeksantapTextStyles.bodyLargeBold,
      bodyMedium: CeksantapTextStyles.bodyLargeMedium,
      bodySmall: CeksantapTextStyles.bodyLargeRegular,
      labelLarge: CeksantapTextStyles.labelLarge,
      labelMedium: CeksantapTextStyles.labelMedium,
      labelSmall: CeksantapTextStyles.labelSmall,
    );
  }

  static TextTheme get _lightTextTheme {
    return TextTheme(
      displayLarge: CeksantapTextStyles.displayLarge.copyWith(color: Colors.grey),
      displayMedium: CeksantapTextStyles.displayMedium.copyWith(color: Colors.grey),
      displaySmall: CeksantapTextStyles.displaySmall.copyWith(color: Colors.grey),
      headlineLarge: CeksantapTextStyles.headlineLarge.copyWith(color: Colors.black),
      headlineMedium: CeksantapTextStyles.headlineMedium.copyWith(color: Colors.black),
      headlineSmall: CeksantapTextStyles.headlineSmall.copyWith(color: Colors.black),
      titleLarge: CeksantapTextStyles.titleLarge.copyWith(color: Colors.grey),
      titleMedium: CeksantapTextStyles.titleMedium.copyWith(color: Colors.grey),
      titleSmall: CeksantapTextStyles.titleSmall.copyWith(color: CeksantapColors.darkGrey),
      bodyLarge: CeksantapTextStyles.bodyLargeBold.copyWith(color: Colors.grey),
      bodyMedium: CeksantapTextStyles.bodyLargeMedium.copyWith(color: Colors.grey),
      bodySmall: CeksantapTextStyles.bodyLargeRegular.copyWith(color: Colors.grey),
      labelLarge: CeksantapTextStyles.labelLarge.copyWith(color: Colors.black),
      labelMedium: CeksantapTextStyles.labelMedium.copyWith(color: Colors.grey),
      labelSmall: CeksantapTextStyles.labelSmall.copyWith(color: Colors.grey),
    );
  }

  static TextTheme get _darkTextTheme {
    return TextTheme(
      displayLarge: CeksantapTextStyles.displayLarge.copyWith(color: Colors.white),
      displayMedium: CeksantapTextStyles.displayMedium.copyWith(color: Colors.white),
      displaySmall: CeksantapTextStyles.displaySmall.copyWith(color: Colors.white),
      headlineLarge: CeksantapTextStyles.headlineLarge.copyWith(color: Colors.white),
      headlineMedium: CeksantapTextStyles.headlineMedium.copyWith(color: Colors.white),
      headlineSmall: CeksantapTextStyles.headlineSmall.copyWith(color: Colors.white),
      titleLarge: CeksantapTextStyles.titleLarge.copyWith(color: Colors.white),
      titleMedium: CeksantapTextStyles.titleMedium.copyWith(color: Colors.white),
      titleSmall: CeksantapTextStyles.titleSmall.copyWith(color: Colors.white),
      bodyLarge: CeksantapTextStyles.bodyLargeBold.copyWith(color: Colors.white),
      bodyMedium: CeksantapTextStyles.bodyLargeMedium.copyWith(color: Colors.white),
      bodySmall: CeksantapTextStyles.bodyLargeRegular.copyWith(color: Colors.white),
      labelLarge: CeksantapTextStyles.labelLarge.copyWith(color: Colors.white),
      labelMedium: CeksantapTextStyles.labelMedium.copyWith(color: Colors.white),
      labelSmall: CeksantapTextStyles.labelSmall.copyWith(color: Colors.white),
    );
  }


  static TabBarThemeData get _lightTabBarTheme {
    return TabBarThemeData(
      indicator: BoxDecoration(
        color: CeksantapColors.primary.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(5),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: CeksantapColors.darkGreen,
      unselectedLabelColor: CeksantapColors.darkGrey,
      labelStyle: CeksantapTextStyles.headlineSmall.copyWith(
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: CeksantapTextStyles.headlineSmall.copyWith(
        fontWeight: FontWeight.w300,
      ),
    );
  }


  static TabBarThemeData get _darkTabBarTheme {
    return TabBarThemeData(
      indicator: BoxDecoration(
        color: CeksantapColors.primary.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(5),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: CeksantapColors.darkGreen,
      unselectedLabelColor: Colors.white,
      labelStyle: CeksantapTextStyles.headlineSmall.copyWith(
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: CeksantapTextStyles.headlineSmall.copyWith(
        fontWeight: FontWeight.w300,
      ),
    );
  }

  static BottomNavigationBarThemeData get _lightBottomNavTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: CeksantapColors.primary,
      unselectedItemColor: CeksantapColors.darkGrey,
      selectedLabelStyle: _lightTextTheme.labelSmall,
      unselectedLabelStyle: _lightTextTheme.labelSmall,
      type: BottomNavigationBarType.fixed,
    );
  }

  static BottomNavigationBarThemeData get _darkBottomNavTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: CeksantapColors.backgroundDark,
      selectedItemColor: CeksantapColors.darkGreen,
      unselectedItemColor: Colors.white70,
      selectedLabelStyle: _darkTextTheme.labelSmall,
      unselectedLabelStyle: _darkTextTheme.labelSmall,
      type: BottomNavigationBarType.fixed,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      elevation: 2,
      backgroundColor: CeksantapColors.primary,
      foregroundColor: Colors.white,
      toolbarTextStyle: _textTheme.titleSmall?.copyWith(
        color: CeksantapColors.darkGreen,
      ),
      titleTextStyle: _textTheme.titleLarge?.copyWith(
        color: CeksantapColors.secondaryGreen,
      ),
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
    );
  }

  static ButtonStyle elevatedButtonStyle({Color? background, Color? textColor, double radius = 16, double paddingV = 18}) {
    return ElevatedButton.styleFrom(
      backgroundColor: background ?? CeksantapColors.paleGreen,
      foregroundColor: textColor ?? Colors.white,
      padding: EdgeInsets.symmetric(vertical: paddingV),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      elevation: 6,
      textStyle: CeksantapTextStyles.bodyLargeBold.copyWith(color: CeksantapColors.secondary, fontSize: 18),
    );
  }

  static ButtonStyle outlinedButtonStyle({Color? borderColor,Color? textColor, double radius = 16, double paddingV = 18}) {
    return OutlinedButton.styleFrom(
      side: BorderSide(color: borderColor ?? CeksantapColors.primary, width: 2),
      foregroundColor: textColor ?? CeksantapColors.secondary,
      padding: EdgeInsets.symmetric(vertical: paddingV),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      textStyle: CeksantapTextStyles.bodyLargeBold.copyWith(color: borderColor ?? CeksantapColors.secondary, fontSize: 18),
    );
  }

  static ButtonStyle filledTonalButtonStyle({
    Color? background,
    Color? textColor,
    double radius = 16,
    double paddingV = 18,
  }) {
    return FilledButton.styleFrom(
      backgroundColor: background ?? CeksantapColors.darkGreen.withValues(alpha: 0.15),
      foregroundColor: textColor ?? CeksantapColors.secondaryGreen,
      padding: EdgeInsets.symmetric(vertical: paddingV, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      textStyle: CeksantapTextStyles.bodyLargeBold.copyWith(
        fontSize: 16,
        color: textColor ?? CeksantapColors.secondaryGreen,
      ),
    );
  }

}
