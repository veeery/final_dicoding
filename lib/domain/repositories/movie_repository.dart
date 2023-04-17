import 'package:dartz/dartz.dart';
import 'package:dicoding_final_ditonton/common/failure.dart';
import 'package:dicoding_final_ditonton/domain/entities/movie/movie.dart';

abstract class MovieRepository {

  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

}