import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute({required int id}) {
    return repository.getMovieDetail(id: id);
  }
}
