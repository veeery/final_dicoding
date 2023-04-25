import 'package:core/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('Save Watchlist', () {
    test('should return success message when insert to database is success', () async {
      // arrange
      when(mockDatabaseHelper.insertTvSeriesWatchlist(tvSeriesTable: tTvSeriesTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertTvSeriesWatchlist(tvSeriesTable: tTvSeriesTable);
      // // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(mockDatabaseHelper.insertTvSeriesWatchlist(tvSeriesTable: tTvSeriesTable)).thenThrow(Exception());
      // act
      final call = dataSource.insertTvSeriesWatchlist(tvSeriesTable: tTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Watchlist', () {
    test('should return success message when remove from database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.removeTvSeriesWatchlist(tvSeriesTable: tTvSeriesTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.removeTvSeriesWatchlist(tvSeriesTable: tTvSeriesTable);
          // assert
          expect(result, 'Removed from Watchlist');
        });

    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.removeTvSeriesWatchlist(tvSeriesTable: tTvSeriesTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.removeTvSeriesWatchlist(tvSeriesTable: tTvSeriesTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('Get Movie Detail By Id', () {
    const int tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => tTvSeriesMap);
      // act
      final result = await dataSource.getTvSeriesById(id: tId);
      // assert
      expect(result, tTvSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvSeriesById(id: tId);
      // assert
      expect(result, null);
    });
  });

  group('Get Watchlist Movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [tTvSeriesMap]);
      // act
      final result = await dataSource.getWatchlistTvSeries();
      // assert
      expect(result, [tTvSeriesTable]);
    });
  });

}