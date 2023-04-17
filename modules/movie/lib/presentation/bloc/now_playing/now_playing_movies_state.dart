part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NowPlayingMoviesEmpty extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesLoaded extends NowPlayingMoviesState {
  final List<Movie> result;

  NowPlayingMoviesLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  NowPlayingMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
