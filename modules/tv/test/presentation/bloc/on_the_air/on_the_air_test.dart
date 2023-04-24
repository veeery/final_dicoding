import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_on_the_air.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'on_the_air_test.mocks.dart';

@GenerateMocks([
  GetOnTheAirTvSeries,
])
void main() {
  late OnTheAirBloc onTheAirBloc;
  late MockGetOnTheAirTvSeries mockGetOnTheAirTvSeries;

  setUp(() {
    mockGetOnTheAirTvSeries = MockGetOnTheAirTvSeries();
    onTheAirBloc = OnTheAirBloc(getOnTheAirTvSeries: mockGetOnTheAirTvSeries);
  });

  test('initial state should be empty', () {
    expect(onTheAirBloc.state, OnTheAirEmpty());
  });

  final tTvSeriesList = <TvSeries>[tTvSeries];

  blocTest<OnTheAirBloc, OnTheAirState>(
    'Should emit [Loading, Loaded]',
    build: () {
      when(mockGetOnTheAirTvSeries.execute()).thenAnswer((realInvocation) async => Right(tTvSeriesList));
      return onTheAirBloc;
    },
    expect: () => [
      OnTheAirLoading(),
      OnTheAirLoaded(tvSeriesList: tTvSeriesList),
    ],
    act: (bloc) => bloc.add(FetchOnTheAir()),
    verify: (bloc) => [
      verify(mockGetOnTheAirTvSeries.execute()),
      FetchOnTheAir().props,
    ],
  );

  blocTest<OnTheAirBloc, OnTheAirState>(
    'Should emit [Loading, Error]',
    build: () {
      when(mockGetOnTheAirTvSeries.execute()).thenAnswer((realInvocation) async => Left(ServerFailure()));
      return onTheAirBloc;
    },
    expect: () => [
      OnTheAirLoading(),
      OnTheAirError(message: 'Server Failure'),
    ],
    act: (bloc) => bloc.add(FetchOnTheAir()),
    verify: (bloc) => [
      verify(mockGetOnTheAirTvSeries.execute()),
      FetchOnTheAir().props,
    ],
  );
}
