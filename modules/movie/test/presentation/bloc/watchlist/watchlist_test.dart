import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_movie_watchlist.dart';
import 'package:movie/domain/usecases/save_movie_watchlist.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_test.mocks.dart';

@GenerateMocks([
  GetWatchListMovie,
  GetMovieWatchListStatus,
  SaveMovieWatchlist,
  RemoveMovieWatchlist,
])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchListMovie mockGetWatchListMovie;
  late MockGetMovieWatchListStatus mockGetMovieWatchListStatus;
  late MockSaveMovieWatchlist mockSaveMovieWatchlist;
  late MockRemoveMovieWatchlist mockRemoveMovieWatchlist;

  setUp(() {
    mockGetWatchListMovie = MockGetWatchListMovie();
    mockGetMovieWatchListStatus = MockGetMovieWatchListStatus();
    mockSaveMovieWatchlist = MockSaveMovieWatchlist();
    mockRemoveMovieWatchlist = MockRemoveMovieWatchlist();
    watchlistMovieBloc = WatchlistMovieBloc(
      getWatchlistMovies: mockGetWatchListMovie,
      saveMovieWatchlist: mockSaveMovieWatchlist,
      removeMovieWatchlist: mockRemoveMovieWatchlist,
      getMovieWatchListStatus: mockGetMovieWatchListStatus,
    );
  });

  test('Initial state should be empty', () {
    expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetWatchListMovie.execute()).thenAnswer((_) async => Left(DatabaseFailure(message: 'Database Failure')));

      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieError(message: 'Database Failure'),
    ],
    verify: (_) => verify(mockGetWatchListMovie.execute()),
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchListMovie.execute()).thenAnswer((_) async => const Right(<Movie>[testWatchlistMovie]));

      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieLoaded(result: const <Movie>[testWatchlistMovie]),
    ],
    verify: (_) => verify(mockGetWatchListMovie.execute()),
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [SaveWatchlist]',
    build: () {
      when(mockSaveMovieWatchlist.execute(movieDetail: testMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(SaveWatchlist(movieDetail: testMovieDetail)),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieStatus(isAdded: true),
    ],
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [RemoveWatchlist]',
    build: () {
      when(mockRemoveMovieWatchlist.execute(movieDetail: testMovieDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlist(movieDetail: testMovieDetail)),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieStatus(isAdded: false),
    ],
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [LoadWatchlistStatus, FALSE or isNotAdded]',
    build: () {
      when(mockGetMovieWatchListStatus.execute(1)).thenAnswer((_) async => false);
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistStatus(movieId: 1)),
    expect: () => [
      WatchlistMovieStatus(isAdded: false),
    ],
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [LoadWatchlistStatus, TRUE or isAdded]',
    build: () {
      when(mockGetMovieWatchListStatus.execute(1)).thenAnswer((_) async => true);
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistStatus(movieId: 1)),
    expect: () => [
      WatchlistMovieStatus(isAdded: true),
    ],
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Error] when data is gotten successfully',
    build: () {
      when(mockGetWatchListMovie.execute()).thenAnswer((_) async => Left(ServerFailure()));

      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieError(message: 'Server Failure')
    ],
    verify: (_) => verify(mockGetWatchListMovie.execute()),
  );

}
