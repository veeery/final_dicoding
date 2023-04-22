import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_movie_watchlist.dart';
import 'package:movie/domain/usecases/save_movie_watchlist.dart';

import '../../../domain/entities/movie.dart';

part 'watchlist_movie_event.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchListMovie getWatchlistMovies;
  final GetMovieWatchListStatus getMovieWatchListStatus;
  final SaveMovieWatchlist saveMovieWatchlist;
  final RemoveMovieWatchlist removeMovieWatchlist;

  WatchlistMovieBloc({
    required this.getWatchlistMovies,
    required this.saveMovieWatchlist,
    required this.removeMovieWatchlist,
    required this.getMovieWatchListStatus,
  }) : super(WatchlistMovieEmpty()) {
    // Fetch Watchlist Movie
    on<FetchWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());

      final result = await getWatchlistMovies.execute();

      result.fold((failure) {
        emit(WatchlistMovieError(message: failure.message));
      }, (watchlist) async {
        if (watchlist.isEmpty) {
          emit(WatchlistMovieEmpty());
        } else {
          emit(WatchlistMovieLoaded(result: watchlist));
        }
      });
    });

    // Fetch Watchlist Status (isAdded or Not)
    on<LoadWatchlistStatus>((event, emit) async {
      final int id = event.movieId;
      final result = await getMovieWatchListStatus.execute(id);
      emit(WatchlistMovieStatus(isAdded: result));
    });

    // Save watchlist
    on<SaveWatchlist>((event, emit) async {
      final movie = event.movieDetail;
      emit(WatchlistMovieLoading());
      final result = await saveMovieWatchlist.execute(movieDetail: movie);

      result.fold(
        (l) => emit(WatchlistMovieError(message: l.message)),
        (r) => emit(WatchlistMovieStatus(isAdded: true)),
      );
    });

    // Remove watchlist
    on<RemoveWatchlist>((event, emit) async {
      final movie = event.movieDetail;
      emit(WatchlistMovieLoading());
      final result = await removeMovieWatchlist.execute(movieDetail: movie);

      result.fold(
        (l) => emit(WatchlistMovieError(message: l.message)),
        (r) => emit(WatchlistMovieStatus(isAdded: false)),
      );
    });
  }
}
