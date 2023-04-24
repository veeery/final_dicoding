import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/entities/season.dart';

class TvSeriesSeasonList extends StatelessWidget {
  final int tvId;
  final List<Season> seasons;

  const TvSeriesSeasonList({
    required this.tvId,
    required this.seasons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final season = seasons[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              // onTap: () => Navigator.pushNamed(
              //   context,
              //   Season,
              //   arguments: {
              //     'id': tvId,
              //     'seasonNumber': season.seasonNumber,
              //   },
              // ),
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: season.posterPath != null
                              ? CachedNetworkImage(
                                  imageUrl: '$BASE_IMAGE_URL${season.posterPath}',
                                  width: 100,
                                  fit: BoxFit.cover,
                                  placeholder: (_, __) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorWidget: (_, __, error) {
                                    return Container(
                                      color: Colors.black26,
                                      child: const Center(
                                        child: Text('No Image'),
                                      ),
                                    );
                                  },
                                )
                              : const Center(child: Icon(Icons.image_not_supported_rounded))),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Center(
                          child: Text(
                            season.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: seasons.length,
      ),
    );
  }
}
