import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gowaroenk/data/api/api_services.dart';
import 'package:gowaroenk/data/model/restaurant.dart';
import 'package:gowaroenk/data/model/restaurant_list_response.dart';
import 'package:gowaroenk/provider/home/restaurant_list_provider.dart';
import 'package:gowaroenk/static/restaurant_list_result_state.dart';

// Mock ApiServices menggunakan mocktail
class MockApiServices extends Mock implements ApiServices {}

void main() {
  late RestaurantListProvider provider;
  late MockApiServices mockApiServices;

  setUp(() {
    mockApiServices = MockApiServices();
    provider = RestaurantListProvider(mockApiServices);
  });

  group('RestaurantListProvider Tests', () {
    test('Initial state harus RestaurantListNoneState', () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test('fetchRestaurantList berhasil', () async {
      final mockRestaurants = [
        Restaurant(id: '1', name: 'Restoran A', description: '', pictureId: '', city: '', rating: 4.0),
        Restaurant(id: '2', name: 'Restoran B', description: '', pictureId: '', city: '', rating: 4.5),
      ];

      final mockResponse = RestaurantListResponse(
        error: false,
        message: 'success',
        count: 2,
        restaurants: mockRestaurants,
      );

      when(() => mockApiServices.getRestaurantList())
          .thenAnswer((_) async => mockResponse);

      await provider.fetchRestaurantList();

      final state = provider.resultState;
      expect(state, isA<RestaurantListLoadedState>());
      expect((state as RestaurantListLoadedState).data.length, 2);
      expect(state.data[0].name, 'Restoran A');
    });

    test('fetchRestaurantList gagal', () async {
      final mockResponse = RestaurantListResponse(
        error: true,
        message: 'Gagal mengambil data',
        count: 0,
        restaurants: [],
      );

      when(() => mockApiServices.getRestaurantList())
          .thenAnswer((_) async => mockResponse);

      await provider.fetchRestaurantList();

      final state = provider.resultState;
      expect(state, isA<RestaurantListErrorState>());
      expect((state as RestaurantListErrorState).error, 'Gagal mengambil data');
    });

    test('searchRestaurant berhasil', () async {
      final mockRestaurants = [
        Restaurant(id: '3', name: 'Restoran C', description: '', pictureId: '', city: '', rating: 4.2),
      ];

      final mockResponse = RestaurantListResponse(
        error: false,
        message: 'success',
        count: 1,
        restaurants: mockRestaurants,
      );

      when(() => mockApiServices.searchRestaurant('C'))
          .thenAnswer((_) async => mockResponse);

      await provider.searchRestaurant('C');

      final state = provider.resultState;
      expect(state, isA<RestaurantListLoadedState>());
      expect((state as RestaurantListLoadedState).data[0].name, 'Restoran C');
    });

    test('searchRestaurant gagal', () async {
      final mockResponse = RestaurantListResponse(
        error: true,
        message: 'Tidak ditemukan',
        count: 0,
        restaurants: [],
      );

      when(() => mockApiServices.searchRestaurant('XYZ'))
          .thenAnswer((_) async => mockResponse);

      await provider.searchRestaurant('XYZ');

      final state = provider.resultState;
      expect(state, isA<RestaurantListErrorState>());
      expect((state as RestaurantListErrorState).error, 'Tidak ditemukan');
    });

    test('searchRestaurant dengan query kosong memanggil fetchRestaurantList', () async {
      final mockRestaurants = [
        Restaurant(id: '1', name: 'Restoran A', description: '', pictureId: '', city: '', rating: 4.0),
      ];

      final mockResponse = RestaurantListResponse(
        error: false,
        message: 'success',
        count: 1,
        restaurants: mockRestaurants,
      );

      when(() => mockApiServices.getRestaurantList())
          .thenAnswer((_) async => mockResponse);

      await provider.searchRestaurant('');

      final state = provider.resultState;
      expect(state, isA<RestaurantListLoadedState>());
      expect((state as RestaurantListLoadedState).data[0].name, 'Restoran A');
    });
  });
}
