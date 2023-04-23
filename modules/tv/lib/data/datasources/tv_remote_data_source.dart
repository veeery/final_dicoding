import 'dart:convert';

import 'package:core/common/constants.dart';
import 'package:core/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:tv/data/model/tv_series_model.dart';
import 'package:tv/data/model/tv_series_response.dart';

abstract class TvRemoteDataSource {
  Future<List<TvSeriesModel>> getOnTheAirTvSeries();
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

}