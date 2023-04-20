import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../movie_popular/movie_popuar_test.mocks.dart';

@GenerateMocks([
  GetPopularMovies,
])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(getPopularMovies: mockGetPopularMovies);
  });

  test('initial empty state', () {
    expect(popularMoviesBloc.state, PopularMovieEmpty());
  });

  final testMovieList = <Movie>[testMovie];

  blocTest<PopularMoviesBloc, PopularMoviesState>('Should emit [Loading, Loaded] when data is successfully',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        return popularMoviesBloc;
      },
      act: (bloc) {
        return bloc.add(const FetchPopularMovies());
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
            PopularMovieLoading(),
            PopularMovieLoaded(result: testMovieList),
          ],
      verify: (_) => [
            verify(mockGetPopularMovies.execute()),
            const FetchPopularMovies().props,
          ]);

  blocTest<PopularMoviesBloc, PopularMoviesState>('Should emit [Loading, Empty] when data is empty',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((_) async => const Right([]));
        return popularMoviesBloc;
      },
      act: (bloc) {
        return bloc.add(const FetchPopularMovies());
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
            PopularMovieLoading(),
            PopularMovieEmpty(),
          ],
      verify: (_) => [
            verify(mockGetPopularMovies.execute()),
            const FetchPopularMovies().props,
          ]);

  blocTest<PopularMoviesBloc, PopularMoviesState>('Should emit [Loading, Error] when get data is failed',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((_) async => Left(ServerFailure()));
        return popularMoviesBloc;
      },
      act: (bloc) {
        return bloc.add(const FetchPopularMovies());
      },
      expect: () => [
            PopularMovieLoading(),
            PopularMovieError(message: 'Server Failure'),
          ],
      verify: (_) => [
            verify(mockGetPopularMovies.execute()),
            const FetchPopularMovies().props,
          ]);
}
