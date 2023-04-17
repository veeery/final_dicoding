import 'package:dicoding_final_ditonton/presentation/pages/movie/movie_home_page.dart';
import 'package:dicoding_final_ditonton/presentation/pages/movie/now_playing_movies_page.dart';
import 'package:dicoding_final_ditonton/presentation/pages/tv/tv_home_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic>? appGenerateRoute({required RouteSettings settings}) {
    switch (settings.name) {
      // Movie
      case MovieHomePage.routeName:
        return MaterialPageRoute(
          builder: (context) => MovieHomePage(),
        );
      case NowPlayingMoviesPage.routeName:
        return MaterialPageRoute(
          builder: (context) => NowPlayingMoviesPage(),
        );
      // Tv Series
      case TvHomePage.routeName:
        return MaterialPageRoute(
          builder: (context) => TvHomePage(),
        );
    }
  }
}
