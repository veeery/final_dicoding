import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/search_movies.dart';

part 'search_movies_event.dart';

part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc({required this.searchMovies}) : super(SearchMoviesEmpty()) {
    on<FetchSearchMovies>((event, emit) async {
      emit(SearchMoviesLoading());

      final result = await searchMovies.execute(event.query);

      result.fold((failure) {
        emit(SearchMoviesError(message: failure.message));
      }, (searchMoviesData) {
        if (searchMoviesData.isEmpty) {
          emit(SearchMoviesEmpty());
        } else {
          emit(SearchMoviesLoaded(result: searchMoviesData));
        }
      });
    });
  }
}
