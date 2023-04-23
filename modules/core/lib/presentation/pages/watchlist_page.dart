import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMovieBloc>().add(FetchWatchlistMovie());
    });
  }

  int page = 0;

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: page);

    AppResponsive.init(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          children: [
            AppCategoryFilm(
                index: page,
                onTap: (int index) {
                  setState(() {
                    page = index;
                    pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 1000), curve: Curves.ease);
                  });
                }),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (int value) {
                  setState(() {
                    page = value;
                  });
                },
                children: [
                  BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                    builder: (context, state) {
                      if (state is WatchlistMovieLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is WatchlistMovieLoaded) {
                        return SizedBox(
                          height: 140 * state.result.length.toDouble(),
                          child: ListView.builder(
                            itemCount: state.result.length,
                            itemBuilder: (context, index) {
                              final watchlistMovie = state.result[index];
                              return MovieCard(movie: watchlistMovie);
                            },
                          ),
                        );
                      } else if (state is WatchlistMovieError) {
                        return Center(
                          key: const Key('error_message'),
                          child: Text(state.message),
                        );
                      } else {
                        return const Center(
                          child: Text('Empty'),
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AppCategoryFilm extends StatelessWidget {
  int index;
  final Function(int) onTap;

  AppCategoryFilm({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  index = 0;
                  onTap(0);
                  print('aww');
                },
                child: Text('Movie',
                    style: TextStyle(color: index == 0 ? Colors.amber : Colors.white), textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  index = 1;
                  onTap(1);
                },
                child: Text('Tv Series',
                    style: TextStyle(color: index == 1 ? Colors.amber : Colors.white), textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
