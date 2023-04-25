import 'package:core/common/exception.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:tv/data/model/tv_series_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertTvSeriesWatchlist({required TvSeriesTable tvSeriesTable});
  Future<String> removeTvSeriesWatchlist({required TvSeriesTable tvSeriesTable});
  Future<TvSeriesTable?> getTvSeriesById({required int id});
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
}


class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvSeriesTable?> getTvSeriesById({required int id}) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertTvSeriesWatchlist({required TvSeriesTable tvSeriesTable}) async{
    try {
      await databaseHelper.insertTvSeriesWatchlist(tvSeriesTable: tvSeriesTable);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvSeriesWatchlist({required TvSeriesTable tvSeriesTable}) async{
    try {
      await databaseHelper.removeTvSeriesWatchlist(tvSeriesTable: tvSeriesTable);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }




}