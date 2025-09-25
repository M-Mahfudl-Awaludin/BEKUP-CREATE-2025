import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:gowaroenk/data/model/restaurant.dart';

class LocalDatabaseService {
  static final LocalDatabaseService _instance = LocalDatabaseService._internal();
  static Database? _database;

  LocalDatabaseService._internal();

  factory LocalDatabaseService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'gowaroenk.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id TEXT PRIMARY KEY,
            name TEXT,
            city TEXT,
            pictureId TEXT,
            rating REAL
          )
        ''');
      },
    );
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db.insert(
      'favorites',
      {
        'id': restaurant.id,
        'name': restaurant.name,
        'city': restaurant.city,
        'pictureId': restaurant.pictureId,
        'rating': restaurant.rating,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    final maps = await db.query('favorites');

    return List.generate(maps.length, (i) {
      return Restaurant(
        id: maps[i]['id'] as String,
        name: maps[i]['name'] as String,
        description: '', // tidak disimpan di DB
        pictureId: maps[i]['pictureId'] as String,
        city: maps[i]['city'] as String,
        rating: (maps[i]['rating'] as num).toDouble(),
      );
    });
  }

  Future<bool> isFavorite(String id) async {
    final db = await database;
    final maps = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }
}
