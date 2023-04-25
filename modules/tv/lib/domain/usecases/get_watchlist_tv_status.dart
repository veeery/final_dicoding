import 'package:tv/domain/repositories/tv_series_repository.dart';

class GetWatchlistTvSeriesStatus {
  final TvSeriesRepository repository;

  GetWatchlistTvSeriesStatus(this.repository);

  Future<bool> execute({required int id}) async {
    return repository.isAddedToWatchlist(id: id);
  }
}
