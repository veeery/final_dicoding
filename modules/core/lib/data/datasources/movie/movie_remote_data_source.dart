import 'package:core/common/constants.dart';
import 'package:core/common/exception.dart';
import 'package:core/data/models/movie/movie_model.dart';
import 'package:core/data/models/movie/movie_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
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

}