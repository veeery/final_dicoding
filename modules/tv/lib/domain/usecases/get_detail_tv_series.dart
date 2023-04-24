import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';

class GetDetailTvSeries {
  final TvSeriesRepository repository;

  GetDetailTvSeries(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute({required int id}) {
    return repository.getTvSeriesDetail(id: id);
  }
}