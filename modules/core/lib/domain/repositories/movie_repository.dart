import 'package:core/common/failure.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {

  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

}