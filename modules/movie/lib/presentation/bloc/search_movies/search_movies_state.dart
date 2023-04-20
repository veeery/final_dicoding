part of 'search_movies_bloc.dart';

abstract class SearchMoviesState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchMoviesEmpty extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesLoaded extends SearchMoviesState {
  final List<Movie> result;

  SearchMoviesLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class SearchMoviesError extends SearchMoviesState {
  final String message;

  SearchMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
