import 'package:core/common/exception.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:movie/data/model/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertMovieWatchlist({required MovieTable movieTable});
  Future<String> removeMovieWatchlist({required MovieTable movieTable});
  Future<MovieTable?> getMovieById({required int id});
  Future<List<MovieTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertMovieWatchlist({required MovieTable movieTable}) async {
    try {
      await databaseHelper.insertMovieWatchlist(movieTable: movieTable);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeMovieWatchlist({required MovieTable movieTable}) async {
    try {
      await databaseHelper.removeMovieWatchlist(movieTable: movieTable);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById({required int id}) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

}
