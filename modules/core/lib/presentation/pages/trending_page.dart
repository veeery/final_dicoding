import 'package:core/presentation/widgets/app_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_list.dart';

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
          )
        ],
      ),
    );
  }
}
