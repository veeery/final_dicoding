import 'package:core/core.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_movie_watchlist.dart';
import 'package:movie/domain/usecases/save_movie_watchlist.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/recommendations/movie_recommendations_bloc.dart';
import 'package:movie/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';
import 'package:tv/domain/usecases/get_detail_tv_series.dart';
import 'package:tv/domain/usecases/get_on_the_air.dart';
import 'package:tv/domain/usecases/get_popular.dart';
import 'package:tv/domain/usecases/get_season_detail.dart';
import 'package:tv/domain/usecases/get_top_rated.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv/domain/usecases/save_tv_watchlist.dart';
import 'package:tv/domain/usecases/search_tv_series.dart';
import 'package:tv/presentation/bloc/detail_season/season_detail_bloc.dart';
import 'package:tv/presentation/bloc/detail_tv_series/detail_tv_series_bloc.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/recommendation_tv/recommendation_tv_bloc.dart';
import 'package:tv/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';

final locator = GetIt.instance;

void init() {
  injectionMovie();

  injectionTvSeries();

  // Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

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
  locator.registerFactory(() => WatchlistMovieBloc(
        getWatchlistMovies: locator(),
        getMovieWatchListStatus: locator(),
        removeMovieWatchlist: locator(),
        saveMovieWatchlist: locator(),
      ));

  // Use Case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SaveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchListMovie(locator()));
  locator.registerLazySingleton(() => GetMovieWatchListStatus(locator()));

  // Repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // Data Source
  locator.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl(databaseHelper: locator()));
}

void injectionTvSeries() {
  // BloC
  locator.registerFactory(() => OnTheAirBloc(getOnTheAirTvSeries: locator()));
  locator.registerFactory(() => PopularTvBloc(getPopularTvSeries: locator()));
  locator.registerFactory(() => TopRatedTvBloc(getTopRatedTvSeries: locator()));
  locator.registerFactory(() => DetailTvSeriesBloc(getDetailTvSeries: locator()));
  locator.registerFactory(() => RecommendationTvBloc(getRecommendationTvSeries: locator()));
  locator.registerFactory(() => SearchTvSeriesBloc(searchTvSeries: locator()));
  locator.registerFactory(() => SeasonDetailBloc(getSeasonDetail: locator()));
  locator.registerFactory(() => WatchlistTvSeriesBloc(
        saveTvSeriesWatchlist: locator(),
        removeTvSeriesWatchlist: locator(),
        getWatchlistTvSeries: locator(),
        getWatchlistTvSeriesStatus: locator(),
      ));
  // Use Case
  locator.registerLazySingleton(() => GetOnTheAirTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetDetailTvSeries(locator()));
  locator.registerLazySingleton(() => GetRecommendationTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetSeasonDetail(locator()));
  locator.registerLazySingleton(() => SaveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  // Repository
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  // Data Source
  locator.registerLazySingleton<TvRemoteDataSource>(() => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(() => TvLocalDataSourceImpl(databaseHelper: locator()));
}
