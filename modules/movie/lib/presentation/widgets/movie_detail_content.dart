import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/app_color.dart';
import 'package:core/common/app_curve_size.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/presentation/bloc/recommendations/movie_recommendations_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

class MovieDetailContent extends StatelessWidget {
  final MovieDetail movie;
  final bool isWatchlist;

  const MovieDetailContent({
    Key? key,
    required this.movie,
    required this.isWatchlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: 100.w,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: EdgeInsets.only(top: 11.h),
          child: DraggableScrollableSheet(
            snap: true,
            snapSizes: const [0.5],
            minChildSize: 0.3,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.only(
                  left: 5.w,
                  top: 5.h,
                  right: 5.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(CurveSize.smallCurve)),
                  color: kRichBlack,
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 3.h),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            ElevatedButton.icon(
                              key: const Key('watchlist_button'),
                              onPressed: () {
                                _onPressedWatchlistButton(context);
                              },
                              icon: isWatchlist ? const Icon(Icons.check_rounded) : const Icon(Icons.add_rounded),
                              label: Text(
                                'Watchlist',
                                style: kSubtitle,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            buildRecommendation()
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 48,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(1.h),
            child: CircleAvatar(
              backgroundColor: kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
                tooltip: 'Back',
              ),
            ),
          ),
        )
      ],
    );
  }

  void _onPressedWatchlistButton(BuildContext context) {
    if (isWatchlist) {
      // context.read<MovieWatchlistBloc>().add(RemoveMovieWatchList(movie));
    } else {
      // context.read<MovieWatchlistBloc>().add(InsertMovieWatchlist(movie));
    }
  }

  String _showGenres(List<Genre> genres) {
    String result = '';

    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) return result;

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) return '${hours}h ${minutes}m';

    return '${minutes}m';
  }

  Widget buildRecommendation() {
    return BlocBuilder<MovieRecommendationsBloc, MovieRecommendationsState>(
      key: const Key('build_movie_recommendations'),
      builder: (context, state) {
        if (state is MovieRecommendationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieRecommendationLoaded) {
          if (state.movieRecommendation.isEmpty) {
            return const Text("There's No Recommendation for this Movie");
          }
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Movie movieRecommendation = state.movieRecommendation[index];

                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        MovieDetailPage.ROUTE_NAME,
                        arguments: movieRecommendation.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(CurveSize.smallCurve),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: 'https://image.tmdb.org/t/p/w500${movieRecommendation.posterPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.movieRecommendation.length,
            ),
          );
        } else if (state is MovieRecommendationEmpty) {
          return const Text('-');
        } else {
          return const Text('Failed');
        }
      },
    );
  }
}
