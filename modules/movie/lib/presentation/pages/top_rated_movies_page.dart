import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top-rated-movies';
  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedMoviesBloc>().add(const FetchTopRatedMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated'),
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
        child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (_, state) {
            if (state is TopRatedMoviesLoading) {
              return const CircularProgressIndicator();
            } else if (state is TopRatedMoviesLoaded) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                  // return Text('aw');
                },
              );
            } else if (state is TopRatedMoviesError) {
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
  }
}
