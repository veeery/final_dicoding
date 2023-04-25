
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/model/tv_series_table.dart';
import 'package:tv/domain/entities/tv_series.dart';

void main() {
  const tTvSeriesTable = TvSeriesTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  const tTvSeriesWatchlist = TvSeries.watchlist(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  const tTvSeriesJson = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should be a subclass of TvSeriesTable entity', () async {
    final result = tTvSeriesTable.toEntity();
    expect(result, tTvSeriesWatchlist);
  });

  test('should be a subclass of TvSeriesTable json', () async {
    final result = tTvSeriesTable.toJson();
    expect(result, tTvSeriesJson);
  });
}