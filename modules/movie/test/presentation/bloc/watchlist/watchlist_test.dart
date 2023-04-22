import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_test.mocks.dart';

@GenerateMocks([
  GetWatchListMovie,
])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchListMovie mockGetWatchListMovie;

  setUp(() {
    mockGetWatchListMovie = MockGetWatchListMovie();
    watchlistMovieBloc = WatchlistMovieBloc(getWatchlistMovies: mockGetWatchListMovie);
  });

  test('Initial state should be empty', () {
    expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
  });

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
}
