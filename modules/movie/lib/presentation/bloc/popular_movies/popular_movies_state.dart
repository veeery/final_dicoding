part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  @override
  List<Object> get props => [];
}

class PopularMovieEmpty extends PopularMoviesState {}

class PopularMovieLoading extends PopularMoviesState {}

class PopularMovieLoaded extends PopularMoviesState {
  final List<Movie> result;

  PopularMovieLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class PopularMovieError extends PopularMoviesState {
  final String message;

  PopularMovieError({required this.message});

  @override
  List<Object> get props => [message];
}
