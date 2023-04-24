import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/model/season_model.dart';
import 'package:tv/data/model/tv_series_detail_model.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';

void main() {
  final  tTvSeriesDetailModel = TvSeriesDetailResponse(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [
      GenreModel(
        id: 1,
        name: 'name',
      ),
    ],
    homepage: 'homepage',
    id: 1,
    inProduction: true,
    languages: ['en'],
    lastAirDate: 'lastAirDate',
    name: 'name',
    numberOfEpisodes: 12,
    numberOfSeasons: 5,
    originCountry: ['en'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 2.3,
    posterPath: 'posterPath',
    seasons: const [
      SeasonModel(
        airDate: 'airDate',
        episodeCount: 12,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      ),
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 2.3,
    voteCount: 1500,
  );

  const tTvSeriesDetail = TvSeriesDetail(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [
      Genre(
        id: 1,
        name: 'name',
      ),
    ],
    id: 1,
    lastAirDate: 'lastAirDate',
    name: 'name',
    numberOfEpisodes: 12,
    numberOfSeasons: 5,
    overview: 'overview',
    posterPath: 'posterPath',
    seasons: [
      Season(
        airDate: 'airDate',
        episodeCount: 12,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      ),
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 2.3,
    voteCount: 1500,
  );

  const tTvSeriesDetailJson = {
    'backdrop_path': 'backdropPath',
    'first_air_date': 'firstAirDate',
    'genres': [
      {
        'id': 1,
        'name': 'name',
      },
    ],
    'homepage': 'homepage',
    'id': 1,
    'in_production': true,
    'languages': ['en'],
    'last_air_date': 'lastAirDate',
    'name': 'name',
    'number_of_episodes': 12,
    'number_of_seasons': 5,
    'origin_country': ['en'],
    'original_language': 'originalLanguage',
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 2.3,
    'poster_path': 'posterPath',
    'seasons': [
      {
        'air_date': 'airDate',
        'episode_count': 12,
        'id': 1,
        'name': 'name',
        'overview': 'overview',
        'poster_path': 'posterPath',
        'season_number': 1,
      },
    ],
    'status': 'status',
    'tagline': 'tagline',
    'type': 'type',
    'vote_average': 2.3,
    'vote_count': 1500,
  };

  test('should be a subclass of TV Series Detail entity', () {
    final result = tTvSeriesDetailModel.toEntity();
    expect(result, tTvSeriesDetail);
  });

  test('should be a subclass of TV Series Detail json', () {
    final result = tTvSeriesDetailModel.toJson();
    expect(result, tTvSeriesDetailJson);
  });
}