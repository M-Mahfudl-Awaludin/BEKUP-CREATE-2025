import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/mealdb_model.dart';

class MealService {
  static const String baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<Meal?> searchMealByName(String name) async {
    final response = await http.get(Uri.parse("$baseUrl/search.php?s=$name"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["meals"] != null && data["meals"].isNotEmpty) {
        return Meal.fromJson(data["meals"][0]);
      }
    }
    return null;
  }
}