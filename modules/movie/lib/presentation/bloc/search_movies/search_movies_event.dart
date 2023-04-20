part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();
}

class FetchSearchMovies extends SearchMoviesEvent {

  final String query;

  const FetchSearchMovies({required this.query});

  @override
  List<Object> get props => [query];
}
