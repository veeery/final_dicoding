import 'package:core/common/app_color.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/main_page.dart';
import 'package:core/presentation/pages/trending_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:dicoding_final_ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'package:tv/presentation/bloc/detail_season/season_detail_bloc.dart';
import 'package:tv/presentation/bloc/detail_tv_series/detail_tv_series_bloc.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/recommendation_tv/recommendation_tv_bloc.dart';
import 'package:tv/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:tv/presentation/pages/detail_tv_page.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:tv/presentation/pages/search_tv_series_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv_series_home_page.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SSLPinning.init();

  di.init();

  runApp(const MyApp());
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
          BlocProvider(
            create: (_) => di.locator<OnTheAirBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TopRatedTvBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<RecommendationTvBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PopularTvBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SearchTvSeriesBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DetailTvSeriesBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SeasonDetailBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<WatchlistTvSeriesBloc>(),
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
                case TrendingPage.routeName:
                  return MaterialPageRoute(builder: (_) => const TrendingPage());
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
                // Tv Series
                case TvSeriesHomePage.routeName:
                  return MaterialPageRoute(builder: (_) => const TvSeriesHomePage());
                case PopularTvSeriesPage.routeName:
                  return MaterialPageRoute(builder: (_) => const PopularTvSeriesPage());
                case TopRatedTvSeriesPage.routeName:
                  return MaterialPageRoute(builder: (_) => const TopRatedTvSeriesPage());
                case SearchTvSeriesPage.routeName:
                  return MaterialPageRoute(builder: (_) => const SearchTvSeriesPage());
                case DetailTvPage.routeName:
                  final id = settings.arguments as int;
                  return MaterialPageRoute(
                    builder: (_) => DetailTvPage(id: id),
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
