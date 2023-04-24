import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_detail_tv_series.dart';
import 'package:tv/presentation/bloc/detail_tv_series/detail_tv_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_test.mocks.dart';

@GenerateMocks([
  GetDetailTvSeries,
])
void main() {
  late DetailTvSeriesBloc detailTvSeriesBloc;
  late MockGetDetailTvSeries mockGetDetailTvSeries;
  const tId = 1;

  setUp(() {
    mockGetDetailTvSeries = MockGetDetailTvSeries();
    detailTvSeriesBloc = DetailTvSeriesBloc(getDetailTvSeries: mockGetDetailTvSeries);
  });

  test('initial state should be empty', () {
    expect(detailTvSeriesBloc.state, DetailTvSeriesEmpty());
  });

  blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
    'Should emit [Loading, Loaded]',
    build: () {
      when(mockGetDetailTvSeries.execute(id: tId)).thenAnswer((realInvocation) async => const Right(tTvSeriesDetail));
      return detailTvSeriesBloc;
    },
    expect: () => [
      DetailTvSeriesLoading(),
      DetailTvSeriesLoaded(result: tTvSeriesDetail),
    ],
    act: (bloc) => bloc.add(const FetchDetailTvSeries(id: tId)),
    verify: (bloc) => [
      verify(mockGetDetailTvSeries.execute(id: tId)),
      const FetchDetailTvSeries(id: tId).props,
    ],
  );

  blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
    'Should emit [Loading, Error]',
    build: () {
      when(mockGetDetailTvSeries.execute(id: tId)).thenAnswer((realInvocation) async => Left(ServerFailure()));
      return detailTvSeriesBloc;
    },
    expect: () => [
      DetailTvSeriesLoading(),
      DetailTvSeriesError(message: 'Server Failure'),
    ],
    act: (bloc) => bloc.add(const FetchDetailTvSeries(id: tId)),
    verify: (bloc) => [
      verify(mockGetDetailTvSeries.execute(id: tId)),
      const FetchDetailTvSeries(id: tId).props,
    ],
  );
}
