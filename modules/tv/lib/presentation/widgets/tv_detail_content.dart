import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/app_color.dart';
import 'package:core/common/app_curve_size.dart';
import 'package:core/common/app_text_style.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/responsive.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';
import 'package:tv/presentation/bloc/recommendation_tv/recommendation_tv_bloc.dart';
import 'package:tv/presentation/pages/detail_tv_page.dart';
import 'package:tv/presentation/widgets/tv_season_episode_widget.dart';

class TvDetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeriesDetail;

  const TvDetailContent(this.tvSeriesDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${tvSeriesDetail.posterPath}',
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(CurveSize.smallCurve)),
                  color: kRichBlack,
                ),
                padding: EdgeInsets.only(
                  left: 5.w,
                  top: 2.h,
                  right: 5.w,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 3.h),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeriesDetail.name,
                              style: kHeading5,
                            ),
                            Text(
                              _showGenres(tvSeriesDetail.genres),
                            ),
                            ElevatedButton.icon(
                              key: const Key('watchlist_button'),
                              onPressed: () async {
                                // _onPressedWatchlistButton(context, message);
                              },
                              icon: true ? const Icon(Icons.check_rounded) : const Icon(Icons.add_rounded),
                              label: Text(
                                'Watchlist',
                                style: kSubtitle,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeriesDetail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeriesDetail.overview,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            TvSeriesSeasonList(
                              tvId: tvSeriesDetail.id,
                              seasons: tvSeriesDetail.seasons,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            buildRecommendation(),
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
        ),
      ],
    );
  }

  Widget buildRecommendation() {
    return BlocBuilder<RecommendationTvBloc, RecommendationTvState>(
      key: const Key('build_tv_recommendations'),
      builder: (_, state) {
        if (state is RecommendationTvLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RecommendationTvLoaded) {
          return SizedBox(
            height: 20.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                TvSeries tvRecommendation = state.recommendationList[index];

                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        DetailTvPage.routeName,
                        arguments: tvRecommendation.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(CurveSize.smallCurve),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: 'https://image.tmdb.org/t/p/w500${tvRecommendation.posterPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.recommendationList.length,
            ),
          );
        } else if (state is RecommendationTvError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            height: 150,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.tv_off),
                  SizedBox(height: 2),
                  Text('No Recommendations'),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';

    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
