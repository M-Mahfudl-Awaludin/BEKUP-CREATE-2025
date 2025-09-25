import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:gowaroenk/screen/bookmark/bookmark_screen.dart';
import 'package:gowaroenk/provider/bookmark/local_database_provider.dart';
import 'package:gowaroenk/data/model/restaurant.dart';
import 'package:gowaroenk/static/navigation_route.dart';
import 'package:gowaroenk/screen/home/restaurant_card_widget.dart';


class MockLocalDatabaseProvider extends Mock implements LocalDatabaseProvider {}

void main() {
  late MockLocalDatabaseProvider mockProvider;

  final testRestaurants = [
    Restaurant(
      id: 'r1',
      name: 'Restoran A',
      description: '',
      pictureId: '',
      city: 'Jakarta',
      rating: 4.0,
    ),
    Restaurant(
      id: 'r2',
      name: 'Restoran B',
      description: '',
      pictureId: '',
      city: 'Bandung',
      rating: 4.5,
    ),
  ];

  setUp(() {
    mockProvider = MockLocalDatabaseProvider();
  });

  Widget createBookmarkScreen() {
    return MaterialApp(
      routes: {
        NavigationRoute.detailRoute.name: (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          return Scaffold(body: Text('Detail Page: $args'));
        },
      },
      home: ChangeNotifierProvider<LocalDatabaseProvider>.value(
        value: mockProvider,
        child: BookmarkScreen(),
      ),
    );
  }

  testWidgets('menampilkan Lottie saat favorites kosong', (tester) async {
    when(() => mockProvider.favorites).thenReturn([]);

    await tester.pumpWidget(createBookmarkScreen());
    await tester.pump(); // cukup pump, jangan pumpAndSettle

    expect(find.text('No Bookmarked Restaurant'), findsOneWidget);
    expect(find.byType(Column), findsWidgets); // cukup cek Column
  });

  testWidgets('menampilkan list restoran saat ada favorites', (tester) async {
    when(() => mockProvider.favorites).thenReturn(testRestaurants);

    await tester.pumpWidget(createBookmarkScreen());
    await tester.pump();

    expect(find.text('Restoran A'), findsOneWidget);
    expect(find.text('Restoran B'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(RestaurantCard), findsNWidgets(2));
  });

  testWidgets('klik RestaurantCard memanggil Navigator.pushNamed', (tester) async {
    when(() => mockProvider.favorites).thenReturn(testRestaurants);

    await tester.pumpWidget(MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == NavigationRoute.detailRoute.name) {
          final args = settings.arguments;
          return MaterialPageRoute(
              builder: (_) => Scaffold(body: Text('Detail Page: $args')));
        }
        return null;
      },
      home: ChangeNotifierProvider<LocalDatabaseProvider>.value(
        value: mockProvider,
        child: BookmarkScreen(),
      ),
    ));

    await tester.pump(); // build initial


    await tester.tap(find.byType(RestaurantCard).first);
    await tester.pump(); // jalankan satu frame
    await tester.pump(); // jalankan frame kedua (animasi navigator)

    expect(find.text('Detail Page: r1'), findsOneWidget);
  });


}
