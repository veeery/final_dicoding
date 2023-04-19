part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;

  MovieDetailLoaded({required this.movieDetail});

  @override
  List<Object> get props => [movieDetail];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError({required this.message});

  @override
  List<Object> get props => [message];
}

