import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({required this.getTopRatedMovies}) : super(TopRatedMoviesEmpty()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(TopRatedMoviesLoading());

      final result = await getTopRatedMovies.execute();

      result.fold((failure) {
        emit(TopRatedMoviesError(message: failure.message));
      }, (topRatedMovies) {
        if (topRatedMovies.isEmpty) {
          emit(TopRatedMoviesEmpty());
        } else {
          emit(TopRatedMoviesLoaded(result: topRatedMovies));
        }
      });
    });
  }
}
