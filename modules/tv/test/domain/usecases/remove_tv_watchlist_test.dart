import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/remove_tv_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late RemoveTvSeriesWatchlist usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveTvSeriesWatchlist(mockTvSeriesRepository);
  });

  test('Should remove tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.removeTvSeriesWatchlist(tvSeriesDetail: tTvSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from Watchlist'));
    // act
    final result = await usecase.execute(tvSeriesDetail: tTvSeriesDetail);
    // assert
    expect(result, const Right('Removed from Watchlist'));
  });
}
