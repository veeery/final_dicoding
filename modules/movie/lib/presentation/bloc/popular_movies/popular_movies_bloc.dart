import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies}) : super(PopularMovieEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMovieLoading());

      final result = await getPopularMovies.execute();

      result.fold((failure) {
        emit(PopularMovieError(message: failure.message));
      }, (dataPopularMovies) {
        if (dataPopularMovies.isEmpty) {
          emit(PopularMovieEmpty());
        } else {
          emit(PopularMovieLoaded(result: dataPopularMovies));
        }
      });
    });
  }
}
