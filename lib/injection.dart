import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/recommendations/movie_recommendations_bloc.dart';
import 'package:movie/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';

final locator = GetIt.instance;

void init() {
  injectionMovie();

  // Helper


  // External
  locator.registerLazySingleton(() => SSLPinning.client);
}

void injectionMovie() {
  // BLoC
  locator.registerFactory(() => NowPlayingMoviesBloc(getNowPlayingMovies: locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(getTopRatedMovies: locator()));
  locator.registerFactory(() => PopularMoviesBloc(getPopularMovies: locator()));
  locator.registerFactory(() => MovieDetailBloc(getMovieDetail: locator()));
  locator.registerFactory(() => SearchMoviesBloc(searchMovies: locator()));
  locator.registerFactory(() => MovieRecommendationsBloc(getMovieRecommendations: locator()));

  // Use Case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));

  // Repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // Data Source
  locator.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: locator()));
}
