import 'package:core/common/app_curve_size.dart';
import 'package:core/common/app_text_style.dart';
import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

class SearchMoviePage extends StatefulWidget {
  static const routeName = '/search-page';

  const SearchMoviePage({Key? key}) : super(key: key);

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchMoviesBloc>().add(FetchSearchMovies(query: query));
              },
              onSubmitted: (query) {
                context.read<SearchMoviesBloc>().add(FetchSearchMovies(query: query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(CurveSize.smallCurve)),
              ),
              textInputAction: TextInputAction.search,
            ),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Expanded(
              child: BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
                builder: (context, state) {
                  if (state is SearchMoviesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchMoviesLoaded) {
                    return ListView.builder(
                      itemCount: state.result.length,
                      itemBuilder: (context, index) {
                        final movie = state.result[index];
                        return MovieCard(movie);
                      },
                    );
                  } else if (state is SearchMoviesError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(child: Text('Empty data'));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
