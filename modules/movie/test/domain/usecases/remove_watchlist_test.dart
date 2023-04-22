import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/remove_movie_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveMovieWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveMovieWatchlist(mockMovieRepository);
  });

  test('should remove movie to the repository', () async {
    // arrange
    when(mockMovieRepository.removeMovieWatchlist(movieDetail: testMovieDetail))
        .thenAnswer((realInvocation) async => const Right('Removed from Watchlist'));
    // act
    final result = await usecase.execute(movieDetail: testMovieDetail);
    // assert
    verify(mockMovieRepository.removeMovieWatchlist(movieDetail: testMovieDetail));
    expect(result, const Right('Removed from Watchlist'));
  });
}
