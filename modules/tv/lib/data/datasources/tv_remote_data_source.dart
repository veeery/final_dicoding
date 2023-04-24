import 'dart:convert';

import 'package:core/common/constants.dart';
import 'package:core/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:tv/data/model/tv_series_model.dart';
import 'package:tv/data/model/tv_series_response.dart';

abstract class TvRemoteDataSource {
  Future<List<TvSeriesModel>> getOnTheAirTvSeries();

  Future<List<TvSeriesModel>> getPopularTvSeries();

  Future<List<TvSeriesModel>> getTopRatedTvSeries();

  Future<List<TvSeriesModel>> searchTvSeries({required String query});

  Future<List<TvSeriesModel>> getRecommendationTvSeries({required int id});
}

class TvSeriesRemoteDataSourceImpl implements TvRemoteDataSource {
  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getOnTheAirTvSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return TvSeriesResponse.fromJson(decoded).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return TvSeriesResponse.fromJson(decoded).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return TvSeriesResponse.fromJson(decoded).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getRecommendationTvSeries({required int id}) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return TvSeriesResponse.fromJson(decoded).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries({required String query}) async {
    final response = await client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return TvSeriesResponse.fromJson(decoded).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
