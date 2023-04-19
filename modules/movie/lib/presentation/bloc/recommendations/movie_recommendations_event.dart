part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsEvent extends Equatable {
  const MovieRecommendationsEvent();
}

class FetchMovieRecommendation extends MovieRecommendationsEvent {
  final int id;

  const FetchMovieRecommendation({required this.id});

  @override
  List<Object> get props => [id];
}