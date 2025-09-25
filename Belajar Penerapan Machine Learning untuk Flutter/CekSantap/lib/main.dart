import 'package:ceksantap/data/api_service/gemini_service.dart';
import 'package:ceksantap/provider/picker_camera/picker_camera_provider.dart';
import 'package:ceksantap/provider/picker_camera/result_provider.dart';
import 'package:ceksantap/screen/home/home_screen_widget.dart';
import 'package:ceksantap/screen/live_camera/live_camera_view.dart';
import 'package:ceksantap/screen/picker_camera/picker_camera_screen.dart';
import 'package:ceksantap/screen/splash/splash_screen_widget.dart';
import 'package:ceksantap/static/navigation_route.dart';
import 'package:ceksantap/style/theme/ceksantap_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'data/api_service/mealdb_service.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final geminiService = GeminiService(apiKey: dotenv.env['GEMINI_API_KEY']!);
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => ResultProvider(MealService(), geminiService), // inject MealService
        ),
        ChangeNotifierProvider(
          create: (_) => PickerCameraProvider(), // inject HttpService
        ),
      ],
      child: MaterialApp(
        title: 'CekSantap',
        theme: CeksantapTheme.lightTheme,
        darkTheme: CeksantapTheme.darkTheme,
        initialRoute: NavigationRoute.splashRoute.name,
        routes: {
          NavigationRoute.splashRoute.name: (context) => const SplashScreen(),
          NavigationRoute.mainRoute.name: (context) => const HomeScreenWidget(),
          NavigationRoute.pickerCameraRoute.name: (context) => const PickerCameraScreen(),
          NavigationRoute.liveCameraRoute.name: (context) => const LiveCameraView(),
        },
      ),
    );
  }
}
