import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';

class RemoveTvSeriesWatchlist {
  final TvSeriesRepository repository;

  RemoveTvSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute({required TvSeriesDetail tvSeriesDetail}) {
    return repository.removeTvSeriesWatchlist(tvSeriesDetail: tvSeriesDetail);
  }
}
