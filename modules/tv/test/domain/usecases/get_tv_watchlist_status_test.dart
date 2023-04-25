import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetWatchlistTvSeriesStatus usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeriesStatus(mockTvSeriesRepository);
  });

  test('Should remove tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.isAddedToWatchlist(id: 1)).thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(id: 1);
    // assert
    expect(result, true);
  });
}
