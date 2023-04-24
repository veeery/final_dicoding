part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecommendationTvLoading extends RecommendationTvState {}

class RecommendationTvEmpty extends RecommendationTvState {}

class RecommendationTvLoaded extends RecommendationTvState {
  final List<TvSeries> recommendationList;

  RecommendationTvLoaded({required this.recommendationList});

  @override
  List<Object> get props => [recommendationList];
}

class RecommendationTvError extends RecommendationTvState {
  final String message;

  RecommendationTvError({required this.message});

  @override
  List<Object> get props => [message];
}
