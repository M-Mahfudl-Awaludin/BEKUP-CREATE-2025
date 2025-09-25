import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gowaroenk/screen/home/home_screen.dart';
import 'package:gowaroenk/provider/home/restaurant_list_provider.dart';
import 'package:gowaroenk/data/model/restaurant.dart';
import 'package:gowaroenk/static/restaurant_list_result_state.dart';

class MockRestaurantListProvider extends Mock implements RestaurantListProvider {}

void main() {
  testWidgets('HomeScreen muncul tanpa animasi Splash', (tester) async {
    final mockProvider = MockRestaurantListProvider();
    when(() => mockProvider.fetchRestaurantList()).thenAnswer((_) async {});
    when(() => mockProvider.resultState).thenReturn(
      RestaurantListLoadedState([
        Restaurant(
          id: 'r1',
          name: 'Restoran A',
          description: '',
          pictureId: '',
          city: 'Jakarta',
          rating: 4.0,
        ),
      ]),
    );

    await tester.pumpWidget(
      ChangeNotifierProvider<RestaurantListProvider>.value(
        value: mockProvider,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pump(); // build pertama

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Restoran A'), findsOneWidget);
  });
}
