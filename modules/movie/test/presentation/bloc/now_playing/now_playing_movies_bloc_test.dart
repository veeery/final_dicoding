import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_movies_bloc_test.mocks.dart';


@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(getNowPlayingMovies: mockGetNowPlayingMovies);
  });

  test('initial empty state', () {
    expect(nowPlayingMoviesBloc.state, NowPlayingMoviesEmpty());
  });

  final testMovieList = <Movie>[testMovie];

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'Should emit [Loading, Loaded] when data is successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Right(testMovieList));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) {
      return bloc.add(const FetchNowPlayingMovies());
    },
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesLoaded(result: testMovieList),
    ],
    verify: (_) => [
      verify(mockGetNowPlayingMovies.execute()),
      const FetchNowPlayingMovies().props,
    ]
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, Empty] when data is empty',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) {
        return bloc.add(const FetchNowPlayingMovies());
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesEmpty(),
      ],
      verify: (_) => [
        verify(mockGetNowPlayingMovies.execute()),
        const FetchNowPlayingMovies().props,
      ]
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, Error] when get data is failed',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure()));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) {
        return bloc.add(const FetchNowPlayingMovies());
      },
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesError(message: 'Server Failure'),
      ],
      verify: (_) => [
        verify(mockGetNowPlayingMovies.execute()),
        const FetchNowPlayingMovies().props,
      ]
  );

}
