part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchTvSeriesEmpty extends SearchTvSeriesState {}

class SearchTvSeriesLoading extends SearchTvSeriesState {}

class SearchTvSeriesLoaded extends SearchTvSeriesState {
  final List<TvSeries> result;

  SearchTvSeriesLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class SearchTvSeriesError extends SearchTvSeriesState {
  final String message;

  SearchTvSeriesError({required this.message});

  @override
  List<Object> get props => [message];
}
