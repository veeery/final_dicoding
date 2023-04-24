import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetRecommendationTvSeries usecase;
  const tId = 1;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetRecommendationTvSeries(mockTvSeriesRepository);
  });

  final testTvSeries = <TvSeries>[];
  test('Should get list popular tv series', () async {
    // arrange
    when(mockTvSeriesRepository.getRecommendationTvSeries(id: tId)).thenAnswer((_) async => Right(testTvSeries));
    // act
    final result = await usecase.execute(id: tId);
    // assert
    expect(result, Right(testTvSeries));
  });
}
