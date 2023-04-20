import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_test.mocks.dart';

@GenerateMocks([
  GetTopRatedMovies,
])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(getTopRatedMovies: mockGetTopRatedMovies);
  });

  test('initial empty state', () {
    expect(topRatedMoviesBloc.state, TopRatedMoviesEmpty());
  });

  final testMovieList = <Movie>[testMovie];

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>('Should emit [Loading, Loaded] when data is successfully',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) {
        return bloc.add(const FetchTopRatedMovies());
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
            TopRatedMoviesLoading(),
            TopRatedMoviesLoaded(result: testMovieList),
          ],
      verify: (_) => [
            verify(mockGetTopRatedMovies.execute()),
            const FetchTopRatedMovies().props,
          ]);

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>('Should emit [Loading, Empty] when data is empty',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => const Right([]));
        return topRatedMoviesBloc;
      },
      act: (bloc) {
        return bloc.add(const FetchTopRatedMovies());
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
            TopRatedMoviesLoading(),
            TopRatedMoviesEmpty(),
          ],
      verify: (_) => [
            verify(mockGetTopRatedMovies.execute()),
            const FetchTopRatedMovies().props,
          ]);

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>('Should emit [Loading, Error] when get data is failed',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Left(ServerFailure()));
        return topRatedMoviesBloc;
      },
      act: (bloc) {
        return bloc.add(const FetchTopRatedMovies());
      },
      expect: () => [
            TopRatedMoviesLoading(),
            TopRatedMoviesError(message: 'Server Failure'),
          ],
      verify: (_) => [
            verify(mockGetTopRatedMovies.execute()),
            const FetchTopRatedMovies().props,
          ]);
}
