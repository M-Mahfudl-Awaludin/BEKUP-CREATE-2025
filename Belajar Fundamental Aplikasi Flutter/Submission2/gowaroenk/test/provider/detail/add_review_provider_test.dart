import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gowaroenk/provider/detail/add_review_restaurant_provider.dart';
import 'package:gowaroenk/data/api/api_services.dart';
import 'package:gowaroenk/data/model/restaurant.dart';
import 'package:gowaroenk/data/model/review_response.dart';
import 'testable_add_review_provider.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late TestableAddReviewProvider provider;
  late MockApiServices mockApi;

  setUp(() {
    mockApi = MockApiServices();
    provider = TestableAddReviewProvider(mockApi);
  });

  group('AddReviewRestaurantProvider Tests', () {
    test('State awal harus idle', () {
      expect(provider.state, equals(ReviewState.idle));
      expect(provider.reviews, isEmpty);
    });

    test('Berhasil tambah review', () async {
      final mockReviews = [
        CustomerReview(name: "Budi", review: "Mantap", date: "2025-08-23")
      ];

      final mockResponse = ReviewResponse(
        error: false,
        message: "success",
        customerReviews: mockReviews,
      );

      when(() => mockApi.addReview(
        id: any(named: 'id'),
        name: any(named: 'name'),
        review: any(named: 'review'),
      )).thenAnswer((_) async => mockResponse);

      await provider.addReview("r1", "Budi", "Mantap");

      expect(provider.state, equals(ReviewState.success));
      expect(provider.reviews.length, 1);
      expect(provider.reviews.first.review, equals("Mantap"));
    });

    test('Tambah review gagal (exception)', () async {
      when(() => mockApi.addReview(
        id: any(named: 'id'),
        name: any(named: 'name'),
        review: any(named: 'review'),
      )).thenThrow(Exception("No internet"));

      try {
        await provider.addReview("r1", "Budi", "Mantap");
      } catch (_) {}

      expect(provider.state, equals(ReviewState.error));
    });

    test('Reset state kembali idle', () {
      provider.resetState();
      expect(provider.state, equals(ReviewState.idle));
    });
  });
}