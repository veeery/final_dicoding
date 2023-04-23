import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_series.dart';

abstract class TvSeriesRepository {

  // Remote
  Future<Either<Failure, List<TvSeries>>> getOnTheAirTvSeries();

}