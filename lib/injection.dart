import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';

final locator = GetIt.instance;

void init() {
  injectionMovie();

  // External
  locator.registerLazySingleton(() => SSLPinning.client);
}

void injectionMovie() {
  // BLoC
  locator.registerFactory(() => NowPlayingMoviesBloc(getNowPlayingMovies: locator()));

  // Use Case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));

  // Repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // Data Source
  locator.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: locator()));

  // Helper
}
