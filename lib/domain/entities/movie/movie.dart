import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  const Movie({
    required this.id,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  const Movie.watchlist({
    required this.id,
    this.overview,
    this.posterPath,
    this.title,
  })  : adult = null,
        backdropPath = null,
        genreIds = null,
        originalTitle = null,
        popularity = null,
        releaseDate = null,
        video = null,
        voteAverage = null,
        voteCount = null;

  final int id;
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genreIds,
    id,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  ];
}