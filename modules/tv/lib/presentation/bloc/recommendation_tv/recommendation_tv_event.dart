part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvEvent extends Equatable {
  const RecommendationTvEvent();

}

class FetchRecommendationTvSeries extends RecommendationTvEvent {
  final int id;

  const FetchRecommendationTvSeries({required this.id});

  @override
  List<Object> get props => [id];
}