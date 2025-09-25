import 'package:gowaroenk/provider/detail/add_review_restaurant_provider.dart';
import 'package:gowaroenk/data/api/api_services.dart';

class TestableAddReviewProvider extends AddReviewRestaurantProvider {
  final ApiServices mockApi;

  TestableAddReviewProvider(this.mockApi);

  @override
  ApiServices get apiServices => mockApi;
}
