import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/save_tv_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late SaveTvSeriesWatchlist usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveTvSeriesWatchlist(mockTvSeriesRepository);
  });


  test('Should save tv series to the repository', () async {
    // arrange
    when(mockTvSeriesRepository.saveTvSeriesWatchlist(tvSeriesDetail: tTvSeriesDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(tvSeriesDetail: tTvSeriesDetail);
    // assert
    expect(result, const Right('Added to Watchlist'));
  });
}
