import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_detail_tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetDetailTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetDetailTvSeries(mockTvSeriesRepository);
  });

  const tId = 1;
  test('Should get list popular tv series', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(id: tId)).thenAnswer((_) async => const Right(tTvSeriesDetail));
    // act
    final result = await usecase.execute(id: tId);
    // assert
    expect(result, const Right(tTvSeriesDetail));
  });
}
