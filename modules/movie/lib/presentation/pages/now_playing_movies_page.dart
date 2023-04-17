
import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

class NowPlayingMoviesPage extends StatefulWidget {
  static const routeName = '/now-playing-movie';

  @override
  State<NowPlayingMoviesPage> createState() => _NowPlayingMoviesPageState();
}

class _NowPlayingMoviesPageState extends State<NowPlayingMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesBloc>().add(const FetchNowPlayingMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
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
        child: BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
          builder: (_, state) {
            if (state is NowPlayingMoviesLoading) {
              return const CircularProgressIndicator();
            } else if (state is NowPlayingMoviesLoaded) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                  // return Text('aw');
                },
              );
            } else if (state is NowPlayingMoviesError) {
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
