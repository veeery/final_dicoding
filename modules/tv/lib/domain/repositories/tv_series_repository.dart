import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_series.dart';

abstract class TvSeriesRepository {

  // Remote
  Future<Either<Failure, List<TvSeries>>> getOnTheAirTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, List<TvSeries>>> searchTvSeries({required String query});
  Future<Either<Failure, List<TvSeries>>> getRecommendationTvSeries({required int id});
}