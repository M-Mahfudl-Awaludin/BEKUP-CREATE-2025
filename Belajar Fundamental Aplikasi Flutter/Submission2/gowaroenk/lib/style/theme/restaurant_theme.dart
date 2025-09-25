import 'package:flutter/material.dart';
import 'package:gowaroenk/style/typography/restaurant_text_styles.dart';

class RestaurantColors {
  static const primary = Color(0xFF003285);
  static const secondary = Color(0xFFFF7043);
  static const secondaryBlue = Color(0xFF2A629A);
  static const accentOrange = Color(0xFFFF7F3E);
  static const softYellow  = Color(0xFFFFDA78);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const backgroundDark = Color(0xFF121212);
  static const darkGrey = Color(0xFF616161);

}

class RestaurantTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: RestaurantColors.primary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: RestaurantColors.backgroundLight,
      textTheme: _lightTextTheme,
      tabBarTheme: _lightTabBarTheme,
      bottomNavigationBarTheme: _lightBottomNavTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: RestaurantColors.primary,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: RestaurantColors.backgroundDark,
      textTheme: _darkTextTheme,
      tabBarTheme: _darkTabBarTheme,
      bottomNavigationBarTheme: _darkBottomNavTheme,
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

  static TextTheme get _lightTextTheme {
    return TextTheme(
      displayLarge: RestaurantTextStyles.displayLarge.copyWith(color: Colors.grey),
      displayMedium: RestaurantTextStyles.displayMedium.copyWith(color: Colors.grey),
      displaySmall: RestaurantTextStyles.displaySmall.copyWith(color: Colors.grey),
      headlineLarge: RestaurantTextStyles.headlineLarge.copyWith(color: Colors.black),
      headlineMedium: RestaurantTextStyles.headlineMedium.copyWith(color: Colors.black),
      headlineSmall: RestaurantTextStyles.headlineSmall.copyWith(color: Colors.black),
      titleLarge: RestaurantTextStyles.titleLarge.copyWith(color: Colors.grey),
      titleMedium: RestaurantTextStyles.titleMedium.copyWith(color: Colors.grey),
      titleSmall: RestaurantTextStyles.titleSmall.copyWith(color: RestaurantColors.darkGrey),
      bodyLarge: RestaurantTextStyles.bodyLargeBold.copyWith(color: Colors.grey),
      bodyMedium: RestaurantTextStyles.bodyLargeMedium.copyWith(color: Colors.grey),
      bodySmall: RestaurantTextStyles.bodyLargeRegular.copyWith(color: Colors.grey),
      labelLarge: RestaurantTextStyles.labelLarge.copyWith(color: Colors.black),
      labelMedium: RestaurantTextStyles.labelMedium.copyWith(color: Colors.grey),
      labelSmall: RestaurantTextStyles.labelSmall.copyWith(color: Colors.grey),
    );
  }

  static TextTheme get _darkTextTheme {
    return TextTheme(
      displayLarge: RestaurantTextStyles.displayLarge.copyWith(color: Colors.white),
      displayMedium: RestaurantTextStyles.displayMedium.copyWith(color: Colors.white),
      displaySmall: RestaurantTextStyles.displaySmall.copyWith(color: Colors.white),
      headlineLarge: RestaurantTextStyles.headlineLarge.copyWith(color: Colors.white),
      headlineMedium: RestaurantTextStyles.headlineMedium.copyWith(color: Colors.white),
      headlineSmall: RestaurantTextStyles.headlineSmall.copyWith(color: Colors.white),
      titleLarge: RestaurantTextStyles.titleLarge.copyWith(color: Colors.white),
      titleMedium: RestaurantTextStyles.titleMedium.copyWith(color: Colors.white),
      titleSmall: RestaurantTextStyles.titleSmall.copyWith(color: Colors.white),
      bodyLarge: RestaurantTextStyles.bodyLargeBold.copyWith(color: Colors.white),
      bodyMedium: RestaurantTextStyles.bodyLargeMedium.copyWith(color: Colors.white),
      bodySmall: RestaurantTextStyles.bodyLargeRegular.copyWith(color: Colors.white),
      labelLarge: RestaurantTextStyles.labelLarge.copyWith(color: Colors.white),
      labelMedium: RestaurantTextStyles.labelMedium.copyWith(color: Colors.white),
      labelSmall: RestaurantTextStyles.labelSmall.copyWith(color: Colors.white),
    );
  }


  static TabBarThemeData get _lightTabBarTheme {
    return TabBarThemeData(
      indicator: BoxDecoration(
        color: RestaurantColors.primary.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(5),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: RestaurantColors.softYellow,
      unselectedLabelColor: RestaurantColors.darkGrey,
      labelStyle: RestaurantTextStyles.headlineSmall.copyWith(
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: RestaurantTextStyles.headlineSmall.copyWith(
        fontWeight: FontWeight.w300,
      ),
    );
  }


  static TabBarThemeData get _darkTabBarTheme {
    return TabBarThemeData(
      indicator: BoxDecoration(
        color: RestaurantColors.primary.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(5),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: RestaurantColors.softYellow,
      unselectedLabelColor: Colors.white,
      labelStyle: RestaurantTextStyles.headlineSmall.copyWith(
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: RestaurantTextStyles.headlineSmall.copyWith(
        fontWeight: FontWeight.w300,
      ),
    );
  }

  static BottomNavigationBarThemeData get _lightBottomNavTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: RestaurantColors.primary,
      unselectedItemColor: RestaurantColors.darkGrey,
      selectedLabelStyle: _lightTextTheme.labelSmall,
      unselectedLabelStyle: _lightTextTheme.labelSmall,
      type: BottomNavigationBarType.fixed,
    );
  }

  static BottomNavigationBarThemeData get _darkBottomNavTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: RestaurantColors.backgroundDark,
      selectedItemColor: RestaurantColors.softYellow,
      unselectedItemColor: Colors.white70,
      selectedLabelStyle: _darkTextTheme.labelSmall,
      unselectedLabelStyle: _darkTextTheme.labelSmall,
      type: BottomNavigationBarType.fixed,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      elevation: 2,
      backgroundColor: RestaurantColors.primary,
      foregroundColor: Colors.white,
      toolbarTextStyle: _textTheme.titleSmall?.copyWith(
        color: RestaurantColors.softYellow,
      ),
      titleTextStyle: _textTheme.titleLarge?.copyWith(
        color: RestaurantColors.accentOrange,
      ),
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
    );
  }
}
