import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/now_playing_movies_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/search_movie_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/widgets/app_heading.dart';
import 'package:movie/presentation/widgets/movie_list.dart';

class MovieHomePage extends StatefulWidget {
  static const routeName = '/movie-home-page';

  const MovieHomePage({super.key});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesBloc>().add(const FetchNowPlayingMovies());
    });
    Future.microtask(() {
      context.read<PopularMoviesBloc>().add(const FetchPopularMovies());
    });
    Future.microtask(() {
      context.read<TopRatedMoviesBloc>().add(const FetchTopRatedMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchMoviePage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          AppHeading(
            title: 'Now Playing',
            onTap: () => Navigator.pushNamed(context, NowPlayingMoviesPage.routeName),
            child: BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
              builder: (context, state) {
                if (state is NowPlayingMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingMoviesLoaded) {
                  return MovieList(movies: state.result);
                } else if (state is NowPlayingMoviesError) {
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
            title: 'Popular Movies',
            onTap: () => Navigator.pushNamed(context, PopularMoviesPage.routeName),
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
            title: 'Top Rated',
            onTap: () => Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
            child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
              builder: (context, state) {
                if (state is TopRatedMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMoviesLoaded) {
                  return MovieList(movies: state.result);
                } else if (state is TopRatedMoviesError) {
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
        ],
      ),
    );
  }
}
