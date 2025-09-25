import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gowaroenk/provider/bookmark/local_database_provider.dart';
import 'package:gowaroenk/data/local/local_database_service.dart';
import 'package:gowaroenk/data/model/restaurant.dart';

class MockLocalDatabaseService extends Mock implements LocalDatabaseService {}

void main() {
  late LocalDatabaseProvider provider;
  late MockLocalDatabaseService mockDb;

  final testRestaurant = Restaurant(
    id: 'r1',
    name: 'Test Restaurant',
    description: 'Desc',
    city: 'Test City',
    pictureId: 'pic1',
    rating: 4.5,
  );

  setUp(() {
    mockDb = MockLocalDatabaseService();
    provider = LocalDatabaseProvider(mockDb);
  });

  group('LocalDatabaseProvider Tests', () {
    test('loadFavorites memuat data dari database', () async {
      when(() => mockDb.getFavorites()).thenAnswer((_) async => [testRestaurant]);

      await provider.loadFavorites();

      expect(provider.favorites.length, 1);
      expect(provider.favorites.first.id, 'r1');
      verify(() => mockDb.getFavorites()).called(1);
    });

    test('addFavorite menambah restoran ke database', () async {
      when(() => mockDb.insertFavorite(testRestaurant)).thenAnswer((_) async {});
      when(() => mockDb.getFavorites()).thenAnswer((_) async => [testRestaurant]);

      await provider.addFavorite(testRestaurant);

      expect(provider.favorites.length, 1);
      expect(provider.favorites.first.id, 'r1');
      verify(() => mockDb.insertFavorite(testRestaurant)).called(1);
      verify(() => mockDb.getFavorites()).called(1);
    });

    test('removeFavorite menghapus restoran dari database', () async {
      when(() => mockDb.removeFavorite('r1')).thenAnswer((_) async {});
      when(() => mockDb.getFavorites()).thenAnswer((_) async => []);

      await provider.removeFavorite('r1');

      expect(provider.favorites, isEmpty);
      verify(() => mockDb.removeFavorite('r1')).called(1);
      verify(() => mockDb.getFavorites()).called(1);
    });

    test('isFavorite mengembalikan true jika ada', () async {
      when(() => mockDb.isFavorite('r1')).thenAnswer((_) async => true);

      final result = await provider.isFavorite('r1');

      expect(result, true);
      verify(() => mockDb.isFavorite('r1')).called(1);
    });

    test('isFavorite mengembalikan false jika tidak ada', () async {
      when(() => mockDb.isFavorite('r2')).thenAnswer((_) async => false);

      final result = await provider.isFavorite('r2');

      expect(result, false);
      verify(() => mockDb.isFavorite('r2')).called(1);
    });
  });
}
