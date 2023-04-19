import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/recommendations/movie_recommendations_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_test.mocks.dart';

@GenerateMocks([
  GetMovieRecommendations,
])
void main() {
  late MovieRecommendationsBloc mockBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  int tId = 1;

  final testMovieList = <Movie>[testMovie];

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockBloc = MovieRecommendationsBloc(getMovieRecommendations: mockGetMovieRecommendations);
  });

  test('initial empty state', () {
    expect(mockBloc.state, MovieRecommendationEmpty());
  });

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'Should emit [Loading, Empty] when get data is empty',
    build: () {
      when(mockGetMovieRecommendations.execute(id: tId)).thenAnswer((_) async => const Right([]));
      return mockBloc;
    },
    act: (bloc) {
      return bloc.add(FetchMovieRecommendation(id: tId));
    },
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationLoaded(movieRecommendation: const[]),
    ],
    verify: (bloc) => [
      verify(mockGetMovieRecommendations.execute(id: tId)),
      FetchMovieRecommendation(id: tId).props,
    ],
  );

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'Should emit [Loading, Loaded] when data is successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(id: tId)).thenAnswer((realInvocation) async => Right(testMovieList));
      return mockBloc;
    },
    act: (bloc) {
      return bloc.add(FetchMovieRecommendation(id: tId));
    },
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationLoaded(movieRecommendation: testMovieList),
    ],
    verify: (bloc) => [
      verify(mockGetMovieRecommendations.execute(id: tId)),
      FetchMovieRecommendation(id: tId).props,
    ],
  );

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'Should emit [Loading, Error] when get data is failed',
    build: () {
      when(mockGetMovieRecommendations.execute(id: tId)).thenAnswer((realInvocation) async => Left(ServerFailure()));
      return mockBloc;
    },
    act: (bloc) {
      return bloc.add(FetchMovieRecommendation(id: tId));
    },
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationError(message: 'Server Failure'),
    ],
    verify: (bloc) => [
      verify(mockGetMovieRecommendations.execute(id: tId)),
      FetchMovieRecommendation(id: tId).props,
    ],
  );
}
