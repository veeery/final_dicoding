import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(MovieDetailEmpty()) {
    // fetch data
    on<FetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());

      final int id = event.id;
      final detailMovie = await getMovieDetail.execute(id: id);

      detailMovie.fold((failure) {
        emit(MovieDetailError(message: failure.message));
      }, (dataMovie)  {
        emit(MovieDetailLoaded(movieDetail: dataMovie));
      });
    });
  }
}
