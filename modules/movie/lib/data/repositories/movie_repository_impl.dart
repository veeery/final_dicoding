import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/model/movie_table.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final result = await remoteDataSource.getNowPlayingMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    } on TlsException {
      return Left(SSLFailure());
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail({required int id}) async {
    try {
      final result = await remoteDataSource.getMovieDetail(id: id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }  on TlsException {
      return Left(SSLFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieRecommendations({required int id}) async {
    try {
      final result = await remoteDataSource.getMovieRecommendations(id: id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }  on TlsException {
      return Left(SSLFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final result = await remoteDataSource.getPopularMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }  on TlsException {
      return Left(SSLFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    try {
      final result = await remoteDataSource.getTopRatedMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }  on TlsException {
      return Left(SSLFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies({required String query}) async {
    try {
      final result = await remoteDataSource.searchMovies(query: query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }  on TlsException {
      return Left(SSLFailure());
    }
  }

  // Local
  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist({required int id}) async {
    final result = await localDataSource.getMovieById(id: id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> saveMovieWatchlist({required MovieDetail movieDetail}) async {
    try {
      final result = await localDataSource.insertMovieWatchlist(movieTable: MovieTable.fromEntity(movieDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeMovieWatchlist({required MovieDetail movieDetail}) async {
    try {
      final result = await localDataSource.removeMovieWatchlist(movieTable: MovieTable.fromEntity(movieDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      rethrow;
    }
  }
}
