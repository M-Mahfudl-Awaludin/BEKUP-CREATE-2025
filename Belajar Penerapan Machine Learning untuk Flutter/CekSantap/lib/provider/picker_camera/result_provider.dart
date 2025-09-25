import 'package:flutter/material.dart';
import 'package:ceksantap/data/api_service/mealdb_service.dart';
import 'package:ceksantap/data/api_service/gemini_service.dart';
import '../../data/model/mealdb_model.dart';
import '../../data/model/nutrition_model.dart';


class ResultProvider extends ChangeNotifier {
  final MealService _mealService;
  final GeminiService _geminiService;
  ResultProvider(this._mealService, this._geminiService);

  Meal? meal;
  bool isLoading = false;
  String? error;
  Nutrition? nutrition;

  Future<void> fetchMeal(String foodName) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      meal = await _mealService.searchMealByName(foodName);
      nutrition = await _geminiService.getNutrition(foodName);
      if (meal == null) {
        error = "Meal not found";
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
