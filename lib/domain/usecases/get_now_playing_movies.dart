import 'package:dartz/dartz.dart';
import 'package:dicoding_final_ditonton/common/failure.dart';
import 'package:dicoding_final_ditonton/domain/entities/movie/movie.dart';
import 'package:dicoding_final_ditonton/domain/repositories/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
