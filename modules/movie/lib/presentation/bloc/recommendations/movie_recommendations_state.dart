part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsState extends Equatable {
  @override
  List<Object> get props => [];
}
// Recommendations

class MovieRecommendationEmpty extends MovieRecommendationsState {}

class MovieRecommendationLoading extends MovieRecommendationsState {}

class MovieRecommendationLoaded extends MovieRecommendationsState {

  final List<Movie> movieRecommendation;

  MovieRecommendationLoaded({required this.movieRecommendation});

  @override
  List<Object> get props => [movieRecommendation];
}

class MovieRecommendationError extends MovieRecommendationsState {
  final String message;

  MovieRecommendationError({required this.message});

  @override
  List<Object> get props => [message];
}
