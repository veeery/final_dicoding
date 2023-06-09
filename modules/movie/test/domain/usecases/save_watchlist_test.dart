import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/save_movie_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveMovieWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveMovieWatchlist(mockMovieRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveMovieWatchlist(movieDetail: testMovieDetail))
        .thenAnswer((realInvocation) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(movieDetail: testMovieDetail);
    // assert
    verify(mockMovieRepository.saveMovieWatchlist(movieDetail: testMovieDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
