import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/app_curve_size.dart';
import 'package:core/common/app_text_style.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isOnCarousel;

  MovieCard({required this.movie, this.isOnCarousel = false});

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(CurveSize.smallCurve),
        onTap: () {
          Navigator.pushNamed(
            context,
            MovieDetailPage.routeName,
            arguments: movie.id,
          );
        },
        child: Stack(
          alignment: isOnCarousel ? Alignment.centerLeft : Alignment.bottomLeft,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(CurveSize.smallCurve),
              ),
              child: Container(
                height: isOnCarousel ? 20.h : 11.h,
                margin: EdgeInsets.only(
                  left: 30.w,
                  bottom: 1.h,
                  right: 2.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      movie.overview ?? '-',
                      maxLines: isOnCarousel ? 5 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 3.w,
                bottom: 3.w,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(CurveSize.smallCurve)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  width: 25.w,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}