import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/app_curve_size.dart';
import 'package:core/common/app_text_style.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/presentation/pages/detail_tv_page.dart';

class TvSeriesCard extends StatelessWidget {
  final TvSeries tvSeries;

  TvSeriesCard({required this.tvSeries});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            DetailTvPage.routeName,
            arguments: tvSeries.id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tvSeries.name ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      tvSeries.overview ?? '-',
                      maxLines: 2,
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
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
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
