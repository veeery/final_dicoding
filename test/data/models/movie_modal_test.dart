import 'package:dicoding_final_ditonton/data/models/movie/movie_model.dart';
import 'package:dicoding_final_ditonton/domain/entities/movie/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MovieModel testMovieModel = const MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  Movie testMovie = const Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Movie Entity', () async {
    final result = testMovieModel.toEntity();
    expect(result, testMovie);
  });
}
