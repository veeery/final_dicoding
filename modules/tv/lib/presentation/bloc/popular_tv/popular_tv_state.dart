part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  @override
  List<Object> get props => [];
}

class PopularTvEmpty extends PopularTvState {}

class PopularTvLoading extends PopularTvState {}

class PopularTvLoaded extends PopularTvState {
  final List<TvSeries> popularTvList;

  PopularTvLoaded({required this.popularTvList});

  @override
  List<Object> get props => [popularTvList];
}

class PopularTvError extends PopularTvState {
  final String message;

  PopularTvError({required this.message});

  @override
  List<Object> get props => [message];
}
