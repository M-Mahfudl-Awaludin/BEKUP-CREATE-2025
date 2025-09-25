import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:gowaroenk/screen/home/home_screen.dart';
import 'package:gowaroenk/provider/home/restaurant_list_provider.dart';
import 'package:gowaroenk/data/model/restaurant.dart';
import 'package:gowaroenk/static/restaurant_list_result_state.dart';

class MockRestaurantListProvider extends Mock implements RestaurantListProvider {}

void main() {
  late MockRestaurantListProvider mockProvider;

  final testRestaurants = [
    Restaurant(id: 'r1', name: 'Restoran A', description: '', pictureId: '', city: 'Jakarta', rating: 4.0),
    Restaurant(id: 'r2', name: 'Restoran B', description: '', pictureId: '', city: 'Bandung', rating: 4.5),
  ];

  setUp(() {
    mockProvider = MockRestaurantListProvider();

    when(() => mockProvider.fetchRestaurantList()).thenAnswer((_) async {});
    when(() => mockProvider.searchRestaurant(any())).thenAnswer((_) async {});
  });

  Widget createHomeScreen() {
    return MaterialApp(
      home: ChangeNotifierProvider<RestaurantListProvider>.value(
        value: mockProvider,
        child: const HomeScreen(),
      ),
    );
  }

  testWidgets('menampilkan Lottie saat loading', (tester) async {
    when(() => mockProvider.resultState).thenReturn(RestaurantListLoadingState());

    await tester.pumpWidget(createHomeScreen());
    await tester.pump(); // post frame callback

    expect(find.byType(Lottie), findsOneWidget);
  });

  testWidgets('menampilkan list restoran saat data tersedia', (tester) async {
    when(() => mockProvider.resultState).thenReturn(
        RestaurantListLoadedState(testRestaurants)
    );

    await tester.pumpWidget(createHomeScreen());
    await tester.pump();

    expect(find.text('Restoran A'), findsOneWidget);
    expect(find.text('Restoran B'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('menampilkan pesan error saat gagal', (tester) async {
    when(() => mockProvider.resultState).thenReturn(
        RestaurantListErrorState('Gagal memuat data')
    );

    await tester.pumpWidget(createHomeScreen());
    await tester.pump();

    expect(find.text('Gagal memuat data'), findsOneWidget);
    expect(find.byType(Lottie), findsOneWidget); // ada Lottie error
  });

  testWidgets('mencari restoran memanggil searchRestaurant', (tester) async {
    when(() => mockProvider.resultState).thenReturn(
        RestaurantListLoadedState(testRestaurants)
    );

    await tester.pumpWidget(createHomeScreen());
    await tester.pump();

    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    await tester.enterText(searchField, 'A');
    await tester.pump(const Duration(milliseconds: 600)); // debounce 500ms

    verify(() => mockProvider.searchRestaurant('A')).called(1);
  });
}