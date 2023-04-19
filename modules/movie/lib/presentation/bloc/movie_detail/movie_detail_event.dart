part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  const FetchMovieDetail({required this.id});

  @override
  List<Object> get props => [id];
}
