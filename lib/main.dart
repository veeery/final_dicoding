import 'package:core/common/app_color.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/main_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:dicoding_final_ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/recommendations/movie_recommendations_bloc.dart';
import 'package:movie/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/movie_home_page.dart';
import 'package:movie/presentation/pages/now_playing_movies_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/search_movie_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SSLPinning.init();

  di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: AppOverlay.mySystemTheme,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.locator<NowPlayingMoviesBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<MovieDetailBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<MovieRecommendationsBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PopularMoviesBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TopRatedMoviesBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SearchMoviesBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<WatchlistMovieBloc>(),
          ),
        ],
        child: MaterialApp(
            theme: ThemeData.dark().copyWith(
              colorScheme: kColorScheme,
              primaryColor: kRichBlack,
              scaffoldBackgroundColor: kRichBlack,
              textTheme: kTextTheme,
            ),
            builder: (context, child) {
              // initial the responsive
              AppResponsive.init(context: context);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: child!,
              );
            },
            title: 'Flutter Ditonton',
            // initialRoute: MainPage.routeName,
            navigatorObservers: [routeObserver],
            home: const MainPage(),
            onGenerateRoute: (settings) {
              switch (settings.name) {
                // main screen for bottom navigator
                case MainPage.routeName:
                  return MaterialPageRoute(builder: (_) => const MainPage());
                // Movie
                case MovieHomePage.routeName:
                  return MaterialPageRoute(builder: (_) => const MovieHomePage());
                case NowPlayingMoviesPage.routeName:
                  return MaterialPageRoute(builder: (_) => const NowPlayingMoviesPage());
                case PopularMoviesPage.routeName:
                  return MaterialPageRoute(builder: (_) => const PopularMoviesPage());
                case TopRatedMoviesPage.routeName:
                  return MaterialPageRoute(builder: (_) => const TopRatedMoviesPage());
                case SearchMoviePage.routeName:
                  return MaterialPageRoute(builder: (_) => const SearchMoviePage());
                case MovieDetailPage.routeName:
                  final id = settings.arguments as int;
                  return MaterialPageRoute(
                    builder: (_) => MovieDetailPage(id: id),
                    settings: settings,
                  );
                // Watchlist
                case WatchlistPage.routeName:
                  return MaterialPageRoute(builder: (_) => const WatchlistPage());
                default:
                  return MaterialPageRoute(builder: (_) {
                    return const Scaffold(
                      body: Center(
                        child: Text('Page not found :('),
                      ),
                    );
                  });
              }
            }),
      ),
    );
  }
}
