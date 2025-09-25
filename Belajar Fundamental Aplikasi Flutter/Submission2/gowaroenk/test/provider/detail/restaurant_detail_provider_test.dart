import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gowaroenk/provider/detail/restaurant_detail_provider.dart';
import 'package:gowaroenk/data/api/api_services.dart';
import 'package:gowaroenk/static/restaurant_detail_result_state.dart';
import 'package:gowaroenk/data/model/restaurant.dart';
import 'package:gowaroenk/data/model/restaurant_detail_response.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late RestaurantDetailProvider provider;
  late MockApiServices mockApi;

  setUp(() {
    mockApi = MockApiServices();
    provider = RestaurantDetailProvider(mockApi);
  });

  group('RestaurantDetailProvider Tests', () {
    test('Initial state harus RestaurantDetailNoneState', () {
      expect(provider.resultState, isA<RestaurantDetailNoneState>());
    });

    test('fetchRestaurantDetail berhasil', () async {
      final restaurant = Restaurant(
        id: "r1",
        name: "Restoran Enak",
        description: "Deskripsi",
        pictureId: "pic1",
        city: "Jakarta",
        rating: 4.5,
      );

      final response = RestaurantDetailResponse(
        error: false,
        message: "success",
        restaurant: restaurant,
      );

      when(() => mockApi.getRestaurantDetail("r1"))
          .thenAnswer((_) async => response);

      await provider.fetchRestaurantDetail("r1");

      expect(provider.resultState, isA<RestaurantDetailLoadedState>());
      final state = provider.resultState as RestaurantDetailLoadedState;
      expect(state.data.name, equals("Restoran Enak"));
    });

    test('fetchRestaurantDetail gagal (API error)', () async {
      final response = RestaurantDetailResponse(
        error: true,
        message: "Data tidak ditemukan",
        restaurant: Restaurant(
          id: "r0",
          name: "",
          description: "",
          pictureId: "",
          city: "",
          rating: 0.0,
        ),
      );

      when(() => mockApi.getRestaurantDetail("r0"))
          .thenAnswer((_) async => response);

      await provider.fetchRestaurantDetail("r0");

      expect(provider.resultState, isA<RestaurantDetailErrorState>());
      final state = provider.resultState as RestaurantDetailErrorState;
      expect(state.error, equals("Data tidak ditemukan"));
    });

    test('fetchRestaurantDetail exception', () async {
      when(() => mockApi.getRestaurantDetail("xxx"))
          .thenThrow(Exception("No Internet"));

      await provider.fetchRestaurantDetail("xxx");

      expect(provider.resultState, isA<RestaurantDetailErrorState>());
      final state = provider.resultState as RestaurantDetailErrorState;
      expect(state.error,
          equals("Gagal memuat data, periksa koneksi internet Anda"));
    });
  });
}