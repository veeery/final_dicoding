part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesEmpty extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoaded extends WatchlistTvSeriesState {
  final List<TvSeries> result;

  WatchlistTvSeriesLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  final String message;

  WatchlistTvSeriesError({required this.message});

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesStatus extends WatchlistTvSeriesState {
  final bool isAdded;

  WatchlistTvSeriesStatus({required this.isAdded});

  @override
  List<Object> get props => [isAdded];
}
