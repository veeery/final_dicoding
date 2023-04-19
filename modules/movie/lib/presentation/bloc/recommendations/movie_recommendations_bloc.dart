import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

part 'movie_recommendations_event.dart';

part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationsBloc({
    required this.getMovieRecommendations,
  }) : super(MovieRecommendationEmpty()) {
    // fetch data from event
    on<FetchMovieRecommendation>((event, emit) async {
      emit(MovieRecommendationLoading());

      final resultRecommendation = await getMovieRecommendations.execute(id: event.id);

      resultRecommendation.fold((failure) {
        emit(MovieRecommendationError(message: failure.message));
      }, (movieRecommendation) {
        emit(MovieRecommendationLoaded(movieRecommendation: movieRecommendation));
      });
    });
  }
}
