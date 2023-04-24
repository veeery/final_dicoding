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

  setUp(() {
    mockRemote = MockTvRemoteDataSource();
    repository = TvSeriesRepositoryImpl(remoteDataSource: mockRemote);
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

}
