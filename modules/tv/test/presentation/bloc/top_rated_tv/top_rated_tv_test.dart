import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_top_rated.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_test.mocks.dart';

@GenerateMocks([
  GetTopRatedTvSeries,
])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvBloc = TopRatedTvBloc(getTopRatedTvSeries: mockGetTopRatedTvSeries);
  });

  test('initial state should be empty', () {
    expect(topRatedTvBloc.state, TopRatedTvEmpty());
  });

  final tTvSeriesList = <TvSeries>[tTvSeries];

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Loaded]',
    build: () {
      when(mockGetTopRatedTvSeries.execute()).thenAnswer((realInvocation) async => Right(tTvSeriesList));
      return topRatedTvBloc;
    },
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvLoaded(topRatedList: tTvSeriesList),
    ],
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    verify: (bloc) => [
      verify(mockGetTopRatedTvSeries.execute()),
      FetchTopRatedTvSeries().props,
    ],
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Error]',
    build: () {
      when(mockGetTopRatedTvSeries.execute()).thenAnswer((realInvocation) async => Left(ServerFailure()));
      return topRatedTvBloc;
    },
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvError(message: 'Server Failure'),
    ],
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    verify: (bloc) => [
      verify(mockGetTopRatedTvSeries.execute()),
      FetchTopRatedTvSeries().props,
    ],
  );
}
