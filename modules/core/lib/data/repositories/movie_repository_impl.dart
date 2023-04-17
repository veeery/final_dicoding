import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:core/data/datasources/movie/movie_remote_data_source.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final result = await remoteDataSource.getNowPlayingMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }
}
