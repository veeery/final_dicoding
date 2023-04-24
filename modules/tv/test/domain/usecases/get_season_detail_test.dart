import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_season_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetSeasonDetail usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetSeasonDetail(mockTvSeriesRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  test('Should get list popular tv series', () async {
    // arrange
    when(mockTvSeriesRepository.getSeasonDetail(id: tId, seasonNumber: tSeasonNumber))
        .thenAnswer((_) async => const Right(tSeasonDetail));
    // act
    final result = await usecase.execute(id: tId, seasonNumber: tSeasonNumber);
    // assert
    expect(result, const Right(tSeasonDetail));
  });
}
