import 'package:flutter/material.dart';
import 'package:gowaroenk/data/model/restaurant.dart';
import 'package:gowaroenk/data/local/local_database_service.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  //final LocalDatabaseService _dbService = LocalDatabaseService();
  final LocalDatabaseService _dbService;

  LocalDatabaseProvider([LocalDatabaseService? dbService])
      : _dbService = dbService ?? LocalDatabaseService();
  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _favorites = await _dbService.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    await _dbService.insertFavorite(restaurant);
    await loadFavorites();
  }

  Future<void> removeFavorite(String id) async {
    await _dbService.removeFavorite(id);
    await loadFavorites();
  }

  Future<bool> isFavorite(String id) async {
    return await _dbService.isFavorite(id);
  }
}
