import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/model/tv_series_model.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/entities/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemote;
  late MockTvLocalDataSource mockLocal;

  setUp(() {
    mockRemote = MockTvRemoteDataSource();
    mockLocal = MockTvLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
    );
  });

  final testTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final testTvSeriesList = <TvSeries>[tTvSeries];

  group('Get On The Air TV Series', () {
    test('Should return remote data when is call successfully', () async {
      // arrange
      when(mockRemote.getOnTheAirTvSeries()).thenAnswer((realInvocation) async => testTvSeriesModelList);
      // act
      final result = await repository.getOnTheAirTvSeries();
      // assert
      verify(mockRemote.getOnTheAirTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvSeriesList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemote.getOnTheAirTvSeries()).thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTvSeries();
      // assert
      verify(mockRemote.getOnTheAirTvSeries());
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemote.getOnTheAirTvSeries()).thenThrow(const SocketException('Failed to Connect to the network'));
      // act
      final result = await repository.getOnTheAirTvSeries();
      // assert
      expect(result, equals(Left(ConnectionFailure())));
    });
  });

  group('Get TopRated TV Series', () {
    test('Should return remote data when is call successfully', () async {
      // arrange
      when(mockRemote.getTopRatedTvSeries()).thenAnswer((realInvocation) async => testTvSeriesModelList);
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      verify(mockRemote.getTopRatedTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvSeriesList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemote.getTopRatedTvSeries()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      verify(mockRemote.getTopRatedTvSeries());
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemote.getTopRatedTvSeries()).thenThrow(const SocketException('Failed to Connect to the network'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(result, equals(Left(ConnectionFailure())));
    });
  });

  group('Get Popular TV Series', () {
    test('Should return remote data when is call successfully', () async {
      // arrange
      when(mockRemote.getPopularTvSeries()).thenAnswer((realInvocation) async => testTvSeriesModelList);
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      verify(mockRemote.getPopularTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvSeriesList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemote.getPopularTvSeries()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      verify(mockRemote.getPopularTvSeries());
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemote.getPopularTvSeries()).thenThrow(const SocketException('Failed to Connect to the network'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(result, equals(Left(ConnectionFailure())));
    });
  });

  group('Get Recommendation TV Series', () {
    const tId = 1;

    test('Should return remote data when is call successfully', () async {
      // arrange
      when(mockRemote.getRecommendationTvSeries(id: tId)).thenAnswer((realInvocation) async => testTvSeriesModelList);
      // act
      final result = await repository.getRecommendationTvSeries(id: tId);
      // assert
      verify(mockRemote.getRecommendationTvSeries(id: tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvSeriesList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemote.getRecommendationTvSeries(id: tId)).thenThrow(ServerException());
      // act
      final result = await repository.getRecommendationTvSeries(id: tId);
      // assert
      verify(mockRemote.getRecommendationTvSeries(id: tId));
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemote.getRecommendationTvSeries(id: tId))
          .thenThrow(const SocketException('Failed to Connect to the network'));
      // act
      final result = await repository.getRecommendationTvSeries(id: tId);
      // assert
      expect(result, equals(Left(ConnectionFailure())));
    });
  });

  group('Search TV Series', () {
    const tQuery = 'batman';

    test('Should return remote data when is call successfully', () async {
      // arrange
      when(mockRemote.searchTvSeries(query: tQuery)).thenAnswer((realInvocation) async => testTvSeriesModelList);
      // act
      final result = await repository.searchTvSeries(query: tQuery);
      // assert
      verify(mockRemote.searchTvSeries(query: tQuery));
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvSeriesList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemote.searchTvSeries(query: tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(query: tQuery);
      // assert
      verify(mockRemote.searchTvSeries(query: tQuery));
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemote.searchTvSeries(query: tQuery))
          .thenThrow(const SocketException('Failed to Connect to the network'));
      // act
      final result = await repository.searchTvSeries(query: tQuery);
      // assert
      expect(result, equals(Left(ConnectionFailure())));
    });
  });

  group('Get Detail TV Series', () {
    const tId = 1;

    test('Should return remote data when is call successfully', () async {
      // arrange
      when(mockRemote.getTvSeriesDetail(id: tId)).thenAnswer((_) async => tTvSeriesResponse);
      // act
      final result = await repository.getTvSeriesDetail(id: tId);
      // assert
      verify(mockRemote.getTvSeriesDetail(id: tId));
      expect(result, equals(const Right(tTvSeriesDetail)));
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemote.getTvSeriesDetail(id: tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesDetail(id: tId);
      // assert
      verify(mockRemote.getTvSeriesDetail(id: tId));
      expect(result, equals(Left(ServerFailure(message: 'Server Failure'))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemote.getTvSeriesDetail(id: tId)).thenThrow(const SocketException('Failed to Connect to the network'));
      // act
      final result = await repository.getTvSeriesDetail(id: tId);
      // assert
      expect(result, equals(Left(ConnectionFailure())));
    });
  });

  group('Get Season Detail TV Series', () {
    const tId = 1;
    const tSeasonNumber = 1;

    test('Should return remote data when is call successfully', () async {
      // arrange
      when(mockRemote.getSeasonDetail(id: tId, seasonNumber: tSeasonNumber))
          .thenAnswer((_) async => tSeasonDetailResponse);
      // act
      final result = await repository.getSeasonDetail(id: tId, seasonNumber: tSeasonNumber);
      // assert
      verify(mockRemote.getSeasonDetail(id: tId, seasonNumber: tSeasonNumber));
      expect(result, equals(const Right(tSeasonDetail)));
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemote.getSeasonDetail(id: tId, seasonNumber: tSeasonNumber)).thenThrow(ServerException());
      // act
      final result = await repository.getSeasonDetail(id: tId, seasonNumber: tSeasonNumber);
      // assert
      verify(mockRemote.getSeasonDetail(id: tId, seasonNumber: tSeasonNumber));
      expect(result, equals(Left(ServerFailure(message: 'Server Failure'))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemote.getSeasonDetail(id: tId, seasonNumber: tSeasonNumber))
          .thenThrow(const SocketException('Failed to Connect to the network'));
      // act
      final result = await repository.getSeasonDetail(id: tId, seasonNumber: tSeasonNumber);
      // assert
      expect(result, equals(Left(ConnectionFailure())));
    });
  });

  group('Save Watchlist TV Series', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocal.insertTvSeriesWatchlist(tvSeriesTable: tTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveTvSeriesWatchlist(tvSeriesDetail: tTvSeriesDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocal.insertTvSeriesWatchlist(tvSeriesTable: tTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveTvSeriesWatchlist(tvSeriesDetail: tTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure(message: 'Failed to add watchlist')));
    });
  });

  group('Remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocal.removeTvSeriesWatchlist(tvSeriesTable: tTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeTvSeriesWatchlist(tvSeriesDetail: tTvSeriesDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocal.removeTvSeriesWatchlist(tvSeriesTable: tTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeTvSeriesWatchlist(tvSeriesDetail: tTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure(message: 'Failed to remove watchlist')));
    });
  });

  group('Get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const int tId = 1;
      when(mockLocal.getTvSeriesById(id: tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(id: tId);
      // assert
      expect(result, false);
    });
  });

  group('Get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockLocal.getWatchlistTvSeries()).thenAnswer((_) async => [tTvSeriesTable]);
      // act
      final result = await repository.getTvSeriesWatchlist();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [tWatchlistTvSeries]);
    });
  });

}
