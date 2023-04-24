import 'package:core/presentation/widgets/app_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_list.dart';
import 'package:tv/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:tv/presentation/widgets/tv_series_list.dart';

class TrendingPage extends StatefulWidget {
  static const routeName = '/trending';

  const TrendingPage({Key? key}) : super(key: key);

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<PopularMoviesBloc>().add(const FetchPopularMovies());
    });
    Future.microtask(() {
      context.read<PopularTvBloc>().add(FetchPopularTvSeries());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending'),
      ),
      body: Column(
        children: [
          AppHeading(
            title: 'Popular Trending Movies',
            child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
              builder: (context, state) {
                if (state is PopularMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMovieLoaded) {
                  return MovieList(movies: state.result);
                } else if (state is PopularMovieError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: Text('Unknown Error'),
                  );
                }
              },
            ),
          ),
          AppHeading(
            title: 'Popular Trending TV Series',
            onTap: () => Navigator.pushNamed(context, PopularTvSeriesPage.routeName),
            child: BlocBuilder<PopularTvBloc, PopularTvState>(
              builder: (context, state) {
                if (state is PopularTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvLoaded) {
                  return TvSeriesList(tvSeriesList: state.popularTvList);
                } else if (state is PopularTvError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: Text('Unknown Error'),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
