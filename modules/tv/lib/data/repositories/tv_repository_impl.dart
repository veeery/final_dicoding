import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/model/tv_series_table.dart';
import 'package:tv/domain/entities/season_detail.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;

  TvSeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
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
    } on TlsException {
      return Left(SSLFailure());
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    try {
      final result = await remoteDataSource.getPopularTvSeries();
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
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvSeries();
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
  Future<Either<Failure, List<TvSeries>>> searchTvSeries({required String query}) async {
    try {
      final result = await remoteDataSource.searchTvSeries(query: query);
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
  Future<Either<Failure, List<TvSeries>>> getRecommendationTvSeries({required int id}) async {
    try {
      final result = await remoteDataSource.getRecommendationTvSeries(id: id);
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
  Future<Either<Failure, SeasonDetail>> getSeasonDetail({required int id, required int seasonNumber}) async {
    try {
      final result = await remoteDataSource.getSeasonDetail(id: id, seasonNumber: seasonNumber);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    } on TlsException {
      return Left(SSLFailure());
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail({required int id}) async {
    try {
      final result = await remoteDataSource.getTvSeriesDetail(id: id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    } on TlsException {
      return Left(SSLFailure());
    }
  }

  // Local
  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesWatchlist() async {
    final result = await localDataSource.getWatchlistTvSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist({required int id}) async {
    final result = await localDataSource.getTvSeriesById(id: id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeTvSeriesWatchlist({required TvSeriesDetail tvSeriesDetail}) async {
    try {
      final result =
          await localDataSource.removeTvSeriesWatchlist(tvSeriesTable: TvSeriesTable.fromEntity(tvSeriesDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> saveTvSeriesWatchlist({required TvSeriesDetail tvSeriesDetail}) async {
    try {
      final result =
          await localDataSource.insertTvSeriesWatchlist(tvSeriesTable: TvSeriesTable.fromEntity(tvSeriesDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      rethrow;
    }
  }
}
