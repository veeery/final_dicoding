import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_on_the_air.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetOnTheAirTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetOnTheAirTvSeries(mockTvSeriesRepository);
  });

  final testTvSeries = <TvSeries>[];
  test('Should get list of on the air tv series', () async {
    // arrange
    when(mockTvSeriesRepository.getOnTheAirTvSeries()).thenAnswer((_) async => Right(testTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvSeries));
  });
}
