part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieLoaded extends WatchlistMovieState {
  final List<Movie> result;

  WatchlistMovieLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  WatchlistMovieError({required this.message});

  @override
  List<Object> get props => [message];
}

class WatchlistMovieStatus extends WatchlistMovieState {
  final bool isAdded;

  WatchlistMovieStatus({required this.isAdded});

  @override
  List<Object> get props => [isAdded];
}
