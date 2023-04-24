import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/season_detail.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';

class GetSeasonDetail {
  final TvSeriesRepository repository;

  GetSeasonDetail(this.repository);

  Future<Either<Failure, SeasonDetail>> execute({required int id, required int seasonNumber}) {
    return repository.getSeasonDetail(id: id, seasonNumber: seasonNumber);
  }
}
