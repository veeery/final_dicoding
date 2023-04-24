part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class DetailTvSeriesEmpty extends DetailTvSeriesState {}

class DetailTvSeriesLoading extends DetailTvSeriesState {}

class DetailTvSeriesLoaded extends DetailTvSeriesState {
  final TvSeriesDetail result;

  DetailTvSeriesLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class DetailTvSeriesError extends DetailTvSeriesState {
  final String message;

  DetailTvSeriesError({required this.message});

  @override
  List<Object> get props => [message];
}
