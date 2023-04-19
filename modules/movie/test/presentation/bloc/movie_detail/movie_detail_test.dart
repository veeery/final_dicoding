import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(getMovieDetail: mockGetMovieDetail);
  });

  int tId = 1;

  test('initial empty state', () {
    expect(movieDetailBloc.state, MovieDetailEmpty());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetMovieDetail.execute(id: tId)).thenAnswer((realInvocation) async => Left(ServerFailure()));
      return movieDetailBloc;
    },
    act: (bloc) => movieDetailBloc.add(FetchMovieDetail(id: tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError(message: 'Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id: tId));
      return FetchMovieDetail(id: tId).props;
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Loaded] when data is successfully',
    build: () {
      when(mockGetMovieDetail.execute(id: tId)).thenAnswer((realInvocation) async => Right(testMovieDetail));
      return movieDetailBloc;
    },
    act: (bloc) => movieDetailBloc.add(FetchMovieDetail(id: tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailLoaded(movieDetail: testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id: tId));
      return FetchMovieDetail(id: tId).props;
    },
  );
}
