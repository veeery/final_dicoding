import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/model/tv_series_model.dart';
import 'package:tv/domain/entities/tv_series.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    posterPath: 'posterPath',
    popularity: 2.3,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 8.1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
  );

  const tTvSeries = TvSeries(
    posterPath: 'posterPath',
    popularity: 2.3,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 8.1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
  );

  test('should be a subclass of TV Series entity', () {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}