import 'package:bloc/bloc.dart';
import 'package:dicoding_final_ditonton/domain/entities/movie/movie.dart';
import 'package:dicoding_final_ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

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
