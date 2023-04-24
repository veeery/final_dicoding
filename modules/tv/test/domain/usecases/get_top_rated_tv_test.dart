import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_top_rated.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetTopRatedTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(mockTvSeriesRepository);
  });

  final testTvSeries = <TvSeries>[];
  test('Should get list top rated tv series', () async {
    // arrange
    when(mockTvSeriesRepository.getTopRatedTvSeries()).thenAnswer((_) async => Right(testTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvSeries));
  });
}
