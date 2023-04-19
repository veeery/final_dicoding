import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/app_text_style.dart';
import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/recommendations/movie_recommendations_bloc.dart';
import 'package:movie/presentation/widgets/movie_detail_content.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/movie-detail';

  final int id;

  MovieDetailPage({required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(FetchMovieDetail(id: widget.id));
      context.read<MovieRecommendationsBloc>().add(FetchMovieRecommendation(id: widget.id));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const CircularProgressIndicator();
          } else if (state is MovieDetailLoaded) {
            final movieDetail = state.movieDetail;
            return MovieDetailContent(
              isWatchlist: false,
              movie: movieDetail,
            );
          } else if (state is MovieDetailError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Empty data'),
            );
          }
        },
      ),
    );
  }
}
