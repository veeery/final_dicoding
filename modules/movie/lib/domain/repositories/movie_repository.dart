import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';

abstract class MovieRepository {
  // Remote
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetail>> getMovieDetail({required int id});
  Future<Either<Failure, List<Movie>>> getMovieRecommendations({required int id});
  Future<Either<Failure, List<Movie>>> searchMovies({required String query});

  // Local
  Future<Either<Failure, String>> saveMovieWatchlist({required MovieDetail movieDetail});
  Future<Either<Failure, String>> removeMovieWatchlist({required MovieDetail movieDetail});
  Future<bool> isAddedToWatchlist({required int id});
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}