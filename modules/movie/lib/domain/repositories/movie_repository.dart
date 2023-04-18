import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie.dart';

abstract class MovieRepository {


  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  // Future<Either<Failure, MovieDetail>> getMovieDetail({required int id});

}