import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';

class GetWatchlistTvSeries {
  final TvSeriesRepository repository;

  GetWatchlistTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTvSeriesWatchlist();
  }
}
