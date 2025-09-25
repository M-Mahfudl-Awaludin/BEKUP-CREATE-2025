import 'package:flutter/foundation.dart';
import 'package:gowaroenk/data/model/restaurant.dart';
import 'package:gowaroenk/data/api/api_services.dart';

enum ReviewState { idle, loading, success, error }

class AddReviewRestaurantProvider with ChangeNotifier {
  final ApiServices apiServices = ApiServices();

  List<CustomerReview> _reviews = [];
  List<CustomerReview> get reviews => _reviews;

  ReviewState _state = ReviewState.idle;
  ReviewState get state => _state;

  Future<void> addReview(String restaurantId, String name, String review) async {
    try {
      _state = ReviewState.loading;
      notifyListeners();

      final response = await apiServices.addReview(
        id: restaurantId,
        name: name,
        review: review,
      );

      _reviews = response.customerReviews;
      _state = ReviewState.success;
      notifyListeners();
    } catch (e) {
      _state = ReviewState.error;
      notifyListeners();

      if (kDebugMode) {
        print("Failed to add review: $e");
      }
      rethrow;
    }
  }

  void resetState() {
    _state = ReviewState.idle;
    notifyListeners();
  }
}
