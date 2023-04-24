import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_detail_tv_series.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/presentation/bloc/detail_tv_series/detail_tv_series_bloc.dart';
import 'package:tv/presentation/bloc/recommendation_tv/recommendation_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_recommendation_test.mocks.dart';

@GenerateMocks([
  GetRecommendationTvSeries,
])
void main() {
  late RecommendationTvBloc recommendationTvBloc;
  late MockGetRecommendationTvSeries mockGetRecommendationTvSeries;
  const tId = 1;

  final testTvSeriesList = <TvSeries>[tTvSeries];

  setUp(() {
    mockGetRecommendationTvSeries = MockGetRecommendationTvSeries();
    recommendationTvBloc = RecommendationTvBloc(getRecommendationTvSeries: mockGetRecommendationTvSeries);
  });

  test('initial state should be empty', () {
    expect(recommendationTvBloc.state, RecommendationTvEmpty());
  });

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [Loading, Loaded]',
    build: () {
      when(mockGetRecommendationTvSeries.execute(id: tId)).thenAnswer((realInvocation) async => Right(testTvSeriesList));
      return recommendationTvBloc;
    },
    expect: () => [
      RecommendationTvLoading(),
      RecommendationTvLoaded(recommendationList: testTvSeriesList),
    ],
    act: (bloc) => bloc.add(const FetchRecommendationTvSeries(id: tId)),
    verify: (bloc) => [
      verify(mockGetRecommendationTvSeries.execute(id: tId)),
      const FetchRecommendationTvSeries(id: tId).props,
    ],
  );

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [Loading, Error]',
    build: () {
      when(mockGetRecommendationTvSeries.execute(id: tId)).thenAnswer((realInvocation) async => Left(ServerFailure()));
      return recommendationTvBloc;
    },
    expect: () => [
      RecommendationTvLoading(),
      RecommendationTvError(message: 'Server Failure'),
    ],
    act: (bloc) => bloc.add(const FetchRecommendationTvSeries(id: tId)),
    verify: (bloc) => [
      verify(mockGetRecommendationTvSeries.execute(id: tId)),
      const FetchRecommendationTvSeries(id: tId).props,
    ],
  );
  
}