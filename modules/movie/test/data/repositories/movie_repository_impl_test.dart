import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:movie/data/model/movie_detail_model.dart';
import 'package:movie/data/model/movie_model.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockMovieRemoteDataSource,
    );
  });

  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  const tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  group('Now Playing Movies', () {
    final tMovieModelList = <MovieModel>[tMovieModel];
    final tMovieList = <Movie>[tMovie];

    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockMovieRemoteDataSource.getNowPlayingMovies()).thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockMovieRemoteDataSource.getNowPlayingMovies());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockMovieRemoteDataSource.getNowPlayingMovies()).thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockMovieRemoteDataSource.getNowPlayingMovies());
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockMovieRemoteDataSource.getNowPlayingMovies())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingMovies();
      // assert
      verify(mockMovieRemoteDataSource.getNowPlayingMovies());
      expect(result, equals(Left(ConnectionFailure())));
    });
  });

  group('Get Movie Detail', () {
    int tId = 1;
    final tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test('should return Movie data when the call to remote data source is successful', () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieDetail(id: tId)).thenAnswer((_) async => tMovieResponse);
      // act
      final result = await repository.getMovieDetail(id: tId);
      // assert
      verify(mockMovieRemoteDataSource.getMovieDetail(id: tId));
      expect(result, equals(Right(testMovieDetail)));
    });

    test('should return Server Failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieDetail(id: tId)).thenThrow(ServerException());
      // act
      final result = await repository.getMovieDetail(id: tId);
      // assert
      verify(mockMovieRemoteDataSource.getMovieDetail(id: tId));
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieDetail(id: tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieDetail(id: tId);
      // assert
      verify(mockMovieRemoteDataSource.getMovieDetail(id: tId));
      expect(result, equals(Left(ConnectionFailure())));
    });
  });

  group('Get Movie Recommendation', () {
    int tId = 1;
    final tMovieModelList = <MovieModel>[];

    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieRecommendations(id: tId)).thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getMovieRecommendations(id: tId);
      // assert
      verify(mockMovieRemoteDataSource.getMovieRecommendations(id: tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieModelList));
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieRecommendations(id: tId)).thenThrow(ServerException());
      // act
      final result = await repository.getMovieRecommendations(id: tId);
      // assert
      verify(mockMovieRemoteDataSource.getMovieRecommendations(id: tId));
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieRecommendations(id: tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieRecommendations(id: tId);
      // assert
      verify(mockMovieRemoteDataSource.getMovieRecommendations(id: tId));
      expect(result, equals(Left(ConnectionFailure())));
    });
  });

  group('Popular Movies', () {
    final tMovieModelList = <MovieModel>[tMovieModel];
    final tMovieList = <Movie>[tMovie];

    test('should return popular movie list when call to data source is success', () async {
      // arrange
      when(mockMovieRemoteDataSource.getPopularMovies()).thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getPopularMovies();

      // assert
      verify(mockMovieRemoteDataSource.getPopularMovies());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return server failure when call to data source is unsuccessful', () async {
      // arrange
      when(mockMovieRemoteDataSource.getPopularMovies()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(result, Left(ServerFailure()));
    });

    test('should return connection failure when device is not connected to the internet', () async {
      // arrange
      when(mockMovieRemoteDataSource.getPopularMovies()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(result, Left(ConnectionFailure()));
    });
  });
}
