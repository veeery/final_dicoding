import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/search_tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late SearchTvSeries usecase;
  const tQuery = 'batman';
  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  final testTvSeries = <TvSeries>[];
  test('Should get list popular tv series', () async {
    // arrange
    when(mockTvSeriesRepository.searchTvSeries(query: tQuery)).thenAnswer((_) async => Right(testTvSeries));
    // act
    final result = await usecase.execute(query: tQuery);
    // assert
    expect(result, Right(testTvSeries));
  });
}
