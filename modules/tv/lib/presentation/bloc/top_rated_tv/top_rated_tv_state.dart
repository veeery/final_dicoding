part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  @override
  List<Object> get props => [];
}

class TopRatedTvEmpty extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvLoaded extends TopRatedTvState {
  final List<TvSeries> topRatedList;

  TopRatedTvLoaded({required this.topRatedList});

  @override
  List<Object> get props => [topRatedList];
}

class TopRatedTvError extends TopRatedTvState {
  final String message;

  TopRatedTvError({required this.message});

  @override
  List<Object> get props => [message];
}
