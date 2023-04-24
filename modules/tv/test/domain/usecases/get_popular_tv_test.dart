import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_popular.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetPopularTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRepository);
  });

  final testTvSeries = <TvSeries>[];
  test('Should get list popular tv series', () async {
    // arrange
    when(mockTvSeriesRepository.getPopularTvSeries()).thenAnswer((_) async => Right(testTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvSeries));
  });
}
