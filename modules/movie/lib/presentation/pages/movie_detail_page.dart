import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/recommendations/movie_recommendations_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_detail_content.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/movie-detail';

  final int id;

  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(FetchMovieDetail(id: widget.id));
      context.read<WatchlistMovieBloc>().add(LoadWatchlistStatus(movieId: widget.id));
      context.read<MovieRecommendationsBloc>().add(FetchMovieRecommendation(id: widget.id));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isWatchlist = context.select<WatchlistMovieBloc, bool>(
      (value) => (value.state is WatchlistMovieStatus) ? (value.state as WatchlistMovieStatus).isAdded : false,
    );

    AppResponsive.init(context: context);
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailLoaded) {
            final movieDetail = state.movieDetail;
            return MovieDetailContent(
              key: const Key('movie_detail_content'),
              isWatchlist: isWatchlist,
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
