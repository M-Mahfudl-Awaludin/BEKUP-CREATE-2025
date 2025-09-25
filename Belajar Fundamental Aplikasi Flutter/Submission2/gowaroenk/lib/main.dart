import 'package:flutter/material.dart';
import 'package:gowaroenk/provider/bookmark/local_database_provider.dart';
import 'package:gowaroenk/provider/detail/add_review_restaurant_provider.dart';
import 'package:gowaroenk/provider/detail/bookmark_icon_provider.dart';
import 'package:gowaroenk/provider/setting/notification_provider.dart';
import 'package:gowaroenk/screen/splash/splash_screen_widget.dart';
import 'package:gowaroenk/service/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:gowaroenk/data/api/api_services.dart';
import 'package:gowaroenk/provider/detail/restaurant_detail_provider.dart';
import 'package:gowaroenk/provider/home/restaurant_list_provider.dart';
import 'package:gowaroenk/provider/main/index_nav_provider.dart';
import 'package:gowaroenk/screen/detail/detail_screen.dart';
import 'package:gowaroenk/screen/main/main_screen.dart';
import 'package:gowaroenk/static/navigation_route.dart';
import 'package:gowaroenk/style/theme/restaurant_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';



class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  ThemeData get currentTheme =>
      _isDarkMode ? RestaurantTheme.darkTheme : RestaurantTheme.lightTheme;

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme(bool isDark) {
    _isDarkMode = isDark;
    _saveTheme(isDark);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('darkMode') ?? false;
    notifyListeners();
  }

  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == bigPictureTask) {
      final service = NotificationService();
      await service.init(); // init notifikasi
      await service.showRestaurantBigPictureNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        payload: '/main',
      );
    }
    return Future.value(true);
  });
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Workmanager().initialize(
    callbackDispatcher,

  );

  final notificationService = NotificationService();
  await notificationService.init();
  await notificationService.configureLocalTimeZone();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),

        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AddReviewRestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookmarkIconProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider()..loadFavorites(),
        ),
        Provider(
          create: (context) => NotificationService()
            ..init()
            ..configureLocalTimeZone(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(
            context.read<NotificationService>(),
          )
            ..requestPermissions()
            ..loadSettings(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Go Waroenk',
          theme: RestaurantTheme.lightTheme,
          darkTheme: RestaurantTheme.darkTheme,
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: NavigationRoute.splashRoute.name, // ganti ke splash screen
          routes: {
            NavigationRoute.splashRoute.name: (context) => const SplashScreen(),
            NavigationRoute.mainRoute.name: (context) => const MainScreen(),
            NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId: ModalRoute.of(context)?.settings.arguments as String,
            ),
          },
        );
      },
    );
  }
}