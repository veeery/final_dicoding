import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv/domain/usecases/save_tv_watchlist.dart';
import 'package:tv/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
  GetWatchlistTvSeriesStatus,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist,
])
void main() {
  late WatchlistTvSeriesBloc mockBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchlistTvSeriesStatus mockGetWatchlistTvSeriesStatus;
  late MockSaveTvSeriesWatchlist mockSaveTvSeriesWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveTvSeriesWatchlist;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchlistTvSeriesStatus = MockGetWatchlistTvSeriesStatus();
    mockSaveTvSeriesWatchlist = MockSaveTvSeriesWatchlist();
    mockRemoveTvSeriesWatchlist = MockRemoveTvSeriesWatchlist();
    mockBloc = WatchlistTvSeriesBloc(
      getWatchlistTvSeries: mockGetWatchlistTvSeries,
      saveTvSeriesWatchlist: mockSaveTvSeriesWatchlist,
      removeTvSeriesWatchlist: mockRemoveTvSeriesWatchlist,
      getWatchlistTvSeriesStatus: mockGetWatchlistTvSeriesStatus,
    );
  });

  test('Initial state should be empty', () {
    expect(mockBloc.state, WatchlistTvSeriesEmpty());
  });

  blocTest<WatchlistTvSeriesBloc  , WatchlistTvSeriesState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvSeries.execute()).thenAnswer((_) async => Left(DatabaseFailure(message: 'Database Failure')));

      return mockBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesError(message: 'Database Failure'),
    ],
    verify: (_) => verify(mockGetWatchlistTvSeries.execute()),
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute()).thenAnswer((_) async => const Right(<TvSeries>[tTvSeries]));

      return mockBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesLoaded(result: const <TvSeries>[tTvSeries]),
    ],
    verify: (_) => verify(mockGetWatchlistTvSeries.execute()),
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [SaveWatchlist]',
    build: () {
      when(mockSaveTvSeriesWatchlist.execute(tvSeriesDetail: tTvSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return mockBloc;
    },
    act: (bloc) => bloc.add(const SaveWatchlistTvEvent(tvSeriesDetail: tTvSeriesDetail)),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesStatus(isAdded: true),
    ],
    verify: (_) => [
      verify(mockSaveTvSeriesWatchlist.execute(tvSeriesDetail: tTvSeriesDetail)),
      const SaveWatchlistTvEvent(tvSeriesDetail: tTvSeriesDetail).props,
    ],
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [RemoveWatchlist]',
    build: () {
      when(mockRemoveTvSeriesWatchlist.execute(tvSeriesDetail: tTvSeriesDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return mockBloc;
    },
    act: (bloc) => bloc.add(const RemoveWatchlistTvEvent(tvSeriesDetail: tTvSeriesDetail)),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesStatus(isAdded: false),
    ],
    verify: (_) => [
      verify(mockRemoveTvSeriesWatchlist.execute(tvSeriesDetail: tTvSeriesDetail)),
      const RemoveWatchlistTvEvent(tvSeriesDetail: tTvSeriesDetail).props,
    ],
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [LoadWatchlistStatus, FALSE or isNotAdded]',
    build: () {
      when(mockGetWatchlistTvSeriesStatus.execute(id: 1)).thenAnswer((_) async => false);
      return mockBloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistStatusEvent(tvSeriesId: 1)),
    expect: () => [
      WatchlistTvSeriesStatus(isAdded: false),
    ],
    verify: (_) => [
      verify(mockGetWatchlistTvSeriesStatus.execute(id: 1)),
      const LoadWatchlistStatusEvent(tvSeriesId: 1).props,
    ],
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [LoadWatchlistStatus, TRUE or isAdded]',
    build: () {
      when(mockGetWatchlistTvSeriesStatus.execute(id: 1)).thenAnswer((_) async => true);
      return mockBloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistStatusEvent(tvSeriesId: 1)),
    expect: () => [
      WatchlistTvSeriesStatus(isAdded: true),
    ],
    verify: (_) => [
      verify(mockGetWatchlistTvSeriesStatus.execute(id: 1)),
      const LoadWatchlistStatusEvent(tvSeriesId: 1).props,
    ],
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, Error] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute()).thenAnswer((_) async => Left(ServerFailure()));

      return mockBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [WatchlistTvSeriesLoading(), WatchlistTvSeriesError(message: 'Server Failure')],
    verify: (_) => [
      verify(mockGetWatchlistTvSeries.execute()),
      FetchWatchlistTvSeries().props,
    ],
  );  
}