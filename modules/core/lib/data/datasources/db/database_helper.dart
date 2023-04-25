import 'package:movie/data/model/movie_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tv/data/model/tv_series_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblMovieWatchlist = 'movie_watchlist';
  static const String _tblTvWatchList = 'tv_watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    final batch = db.batch();
    db.execute('''
      CREATE TABLE  $_tblMovieWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE $_tblTvWatchList (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await batch.commit();
  }

  // Movie
  Future<int> insertMovieWatchlist({required MovieTable movieTable}) async {
    final db = await database;
    return await db!.insert(_tblMovieWatchlist, movieTable.toJson());
  }

  Future<int> removeMovieWatchlist({required MovieTable movieTable}) async {
    final db = await database;
    return await db!.delete(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [movieTable.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblMovieWatchlist);
    return results;
  }

  // TV Series
  Future<int> insertTvSeriesWatchlist({required TvSeriesTable tvSeriesTable}) async {
    final db = await database;
    return await db!.insert(_tblTvWatchList, tvSeriesTable.toJson());
  }

  Future<int> removeTvSeriesWatchlist({required TvSeriesTable tvSeriesTable}) async {
    final db = await database;
    return await db!.delete(
      _tblTvWatchList,
      where: 'id = ?',
      whereArgs: [tvSeriesTable.id],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTvWatchList,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblTvWatchList);
    return results;
  }


}
