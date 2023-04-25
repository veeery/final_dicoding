import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';

class SaveTvSeriesWatchlist {
  final TvSeriesRepository repository;

  SaveTvSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute({required TvSeriesDetail tvSeriesDetail}) {
    return repository.saveTvSeriesWatchlist(tvSeriesDetail: tvSeriesDetail);
  }
}
