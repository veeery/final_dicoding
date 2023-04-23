import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TvRemoteDataSource remoteDataSource;

  TvSeriesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<TvSeries>>> getOnTheAirTvSeries() async {
    try {
      final result = await remoteDataSource.getOnTheAirTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }
}
