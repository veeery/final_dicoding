import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/search_movies/search_movies_bloc.dart';

import 'search_movies_test.mocks.dart';

@GenerateMocks([
  SearchMovies,
])
void main() {
  late SearchMoviesBloc searchMoviesBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMoviesBloc = SearchMoviesBloc(searchMovies: mockSearchMovies);
  });

  const tMovieModel = Movie(
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
  final tMovieList = <Movie>[tMovieModel];
  const String tQuery = 'spiderman';

  test('initial empty state', () {
    expect(searchMoviesBloc.state, SearchMoviesEmpty());
  });

  blocTest<SearchMoviesBloc, SearchMoviesState>('Should emit [Loading, Loaded] when data is successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer((_) async => Right(tMovieList));
        return searchMoviesBloc;
      },
      act: (bloc) {
        return bloc.add(const FetchSearchMovies(query: tQuery));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
            SearchMoviesLoading(),
            SearchMoviesLoaded(result: tMovieList),
          ],
      verify: (_) => [
            verify(mockSearchMovies.execute(tQuery)),
            const FetchSearchMovies(query: tQuery).props,
          ]);

  blocTest<SearchMoviesBloc, SearchMoviesState>('Should emit [Loading, Empty] when data is empty',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer((_) async => const Right([]));
        return searchMoviesBloc;
      },
      act: (bloc) {
        return bloc.add(const FetchSearchMovies(query: tQuery));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
            SearchMoviesLoading(),
            SearchMoviesEmpty(),
          ],
      verify: (_) => [
            verify(mockSearchMovies.execute(tQuery)),
            const FetchSearchMovies(query: tQuery).props,
          ]);

  blocTest<SearchMoviesBloc, SearchMoviesState>('Should emit [Loading, Error] when get data is failed',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer((_) async => Left(ServerFailure()));
        return searchMoviesBloc;
      },
      act: (bloc) {
        return bloc.add(const FetchSearchMovies(query: tQuery));
      },
      expect: () => [
            SearchMoviesLoading(),
            SearchMoviesError(message: 'Server Failure'),
          ],
      verify: (_) => [
            verify(mockSearchMovies.execute(tQuery)),
            const FetchSearchMovies(query: tQuery).props,
          ]);
}
