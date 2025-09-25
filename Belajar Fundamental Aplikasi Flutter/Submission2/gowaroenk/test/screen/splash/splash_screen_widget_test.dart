import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gowaroenk/screen/splash/splash_screen_widget.dart';
import 'package:gowaroenk/static/navigation_route.dart';

void main() {
  testWidgets('SplashScreen menampilkan logo dan navigasi setelah 3 detik', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          NavigationRoute.mainRoute.name: (context) => const Scaffold(
            body: Text('Main Screen'),
          ),
        },
        home: const SplashScreen(),
      ),
    );

    expect(find.byType(Image), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Main Screen'), findsOneWidget);
  });
}
