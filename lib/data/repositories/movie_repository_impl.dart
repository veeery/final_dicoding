import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dicoding_final_ditonton/common/exception.dart';
import 'package:dicoding_final_ditonton/common/failure.dart';
import 'package:dicoding_final_ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:dicoding_final_ditonton/domain/entities/movie/movie.dart';
import 'package:dicoding_final_ditonton/domain/repositories/movie_repository.dart';

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
