import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie.dart';

import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc({required this.getNowPlayingMovies}) : super(NowPlayingMoviesEmpty()) {
    // fetch data
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingMoviesLoading());

      final result = await getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(NowPlayingMoviesError(message: failure.message));
      }, (data) {
        if (data.isEmpty) {
          emit(NowPlayingMoviesEmpty());
        } else {
          emit(NowPlayingMoviesLoaded(result: data));
        }
      });
    });
  }
}
