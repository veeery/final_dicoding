import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  static const routeName = '/popular-movies';

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularMoviesBloc>().add(const FetchPopularMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, searchMoviesRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (_, state) {
            if (state is PopularMovieLoading) {
              return const CircularProgressIndicator();
            } else if (state is PopularMovieLoaded) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                  // return Text('aw');
                },
              );
            } else if (state is PopularMovieError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(child: Text('Empty data'));
            }
          },
        ),
      ),
    );
    ;
  }
}
