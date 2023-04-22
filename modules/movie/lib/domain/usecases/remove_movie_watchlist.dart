import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

import '../entities/movie_detail.dart';

class RemoveMovieWatchlist {
  final MovieRepository repository;

  RemoveMovieWatchlist(this.repository);

  Future<Either<Failure, String>> execute({required MovieDetail movieDetail}) {
    return repository.removeMovieWatchlist(movieDetail: movieDetail);
  }
}
