import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetWatchlistTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('Should remove tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesWatchlist()).thenAnswer((_) async => const Right([tTvSeries]));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, const Right([tTvSeries]));
  });
}
