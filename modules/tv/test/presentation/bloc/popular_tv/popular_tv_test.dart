import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_popular.dart';
import 'package:tv/presentation/bloc/popular_tv/popular_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_test.mocks.dart';

@GenerateMocks([
  GetPopularTvSeries,
])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvBloc = PopularTvBloc(getPopularTvSeries: mockGetPopularTvSeries);
  });

  test('initial state should be empty', () {
    expect(popularTvBloc.state, PopularTvEmpty());
  });

  final tTvSeriesList = <TvSeries>[tTvSeries];

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, Loaded]',
    build: () {
      when(mockGetPopularTvSeries.execute()).thenAnswer((realInvocation) async => Right(tTvSeriesList));
      return popularTvBloc;
    },
    expect: () => [
      PopularTvLoading(),
      PopularTvLoaded(popularTvList: tTvSeriesList),
    ],
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    verify: (bloc) => [
      verify(mockGetPopularTvSeries.execute()),
      FetchPopularTvSeries().props,
    ],
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, Error]',
    build: () {
      when(mockGetPopularTvSeries.execute()).thenAnswer((realInvocation) async => Left(ServerFailure()));
      return popularTvBloc;
    },
    expect: () => [
      PopularTvLoading(),
      PopularTvError(message: 'Server Failure'),
    ],
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    verify: (bloc) => [
      verify(mockGetPopularTvSeries.execute()),
      FetchPopularTvSeries().props,
    ],
  );
  
}