import 'package:dicoding_final_ditonton/common/SSL/ssl_pinning.dart';
import 'package:dicoding_final_ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:dicoding_final_ditonton/data/repositories/movie_repository_impl.dart';
import 'package:dicoding_final_ditonton/domain/repositories/movie_repository.dart';
import 'package:dicoding_final_ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:dicoding_final_ditonton/presentation/bloc/movie/now_playing/now_playing_movies_bloc.dart';
import 'package:get_it/get_it.dart';

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
