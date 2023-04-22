part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();
}

class FetchWatchlistMovie extends WatchlistMovieEvent {
  @override
  List<Object> get props => [];
}

class SaveWatchlist extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const SaveWatchlist({required this.movieDetail});

  @override
  List<Object> get props => [movieDetail];
}

class RemoveWatchlist extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const RemoveWatchlist({required this.movieDetail});

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchlistStatus extends WatchlistMovieEvent {
  final int movieId;


  @override
  List<Object> get props => [movieId];

  const LoadWatchlistStatus({required this.movieId});
}


