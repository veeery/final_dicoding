import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';

class GetRecommendationTvSeries {
  final TvSeriesRepository repository;

  GetRecommendationTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute({required int id}) {
    return repository.getRecommendationTvSeries(id: id);
  }
}
