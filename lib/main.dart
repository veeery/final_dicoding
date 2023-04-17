import 'package:dicoding_final_ditonton/common/SSL/ssl_pinning.dart';
import 'package:dicoding_final_ditonton/common/app_overlay.dart';
import 'package:dicoding_final_ditonton/common/responsive.dart';
import 'package:dicoding_final_ditonton/presentation/bloc/movie/now_playing/now_playing_movies_bloc.dart';
import 'package:dicoding_final_ditonton/presentation/pages/app_routes.dart';
import 'package:dicoding_final_ditonton/presentation/pages/movie/movie_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        ],
        child: MaterialApp(
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
          onGenerateRoute: (settings) => AppRoutes.appGenerateRoute(settings: settings),
        ),
      ),
    );
  }
}
