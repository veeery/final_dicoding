part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();
}

class FetchWatchlistTvSeries extends WatchlistTvSeriesEvent {
  @override
  List<Object> get props => [];
}

class SaveWatchlistTvEvent extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  const SaveWatchlistTvEvent({required this.tvSeriesDetail});

  @override
  List<Object> get props => [tvSeriesDetail];
}

class RemoveWatchlistTvEvent extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveWatchlistTvEvent({required this.tvSeriesDetail});

  @override
  List<Object> get props => [tvSeriesDetail];
}

class LoadWatchlistStatusEvent extends WatchlistTvSeriesEvent {
  final int tvSeriesId;

  const LoadWatchlistStatusEvent({required this.tvSeriesId});

  @override
  List<Object> get props => [tvSeriesId];
}
