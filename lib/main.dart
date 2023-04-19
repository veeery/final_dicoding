
import 'package:core/common/app_color.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/recommendations/movie_recommendations_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/movie_home_page.dart';
import 'package:movie/presentation/pages/now_playing_movies_page.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
          initialRoute: MovieHomePage.routeName,
          onGenerateRoute: (settings) {
            switch(settings.name) {
              case MovieHomePage.routeName:
                return MaterialPageRoute(builder: (_) => MovieHomePage());
              case NowPlayingMoviesPage.routeName:
                return MaterialPageRoute(builder: (_) => NowPlayingMoviesPage());
              case MovieDetailPage.ROUTE_NAME:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id),
                  settings: settings,
                );
            }
          }
        ),
      ),
    );
  }
}
