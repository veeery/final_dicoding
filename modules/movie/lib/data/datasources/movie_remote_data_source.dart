import 'package:core/common/constants.dart';
import 'package:core/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:movie/data/model/movie_detail_model.dart';
import 'dart:convert';

import 'package:movie/data/model/movie_model.dart';
import 'package:movie/data/model/movie_response.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<MovieDetailResponse> getMovieDetail({required int id});
  Future<List<MovieModel>> getMovieRecommendations({required int id});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {

  final http.Client client;
  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail({required int id}) async {
    final response =
    await client.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations({required int id}) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

}