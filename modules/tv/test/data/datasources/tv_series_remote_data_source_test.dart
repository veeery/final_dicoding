import 'dart:convert';

import 'package:core/common/constants.dart';
import 'package:core/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/model/tv_series_response.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get On The Air Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/on_the_air.json'))).tvSeriesList;

    test('Should return list of Tv series', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/on_the_air.json'), 200));
      // act
      final result = await dataSource.getOnTheAirTvSeries();
      // assert
      expect(result, equals(tTvSeriesList));
    });
    test('Should return Server Exception', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/on_the_air.json'), 404));
      // act
      final result = dataSource.getOnTheAirTvSeries();
      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });

  });

  group('Get Top Rated Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/top_rated.json'))).tvSeriesList;

    test('Should return list of Tv series', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvSeries();
      // assert
      expect(result, equals(tTvSeriesList));
    });
    test('Should return Server Exception', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/top_rated.json'), 404));
      // act
      final result = dataSource.getTopRatedTvSeries();
      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });

  });

  group('Get Popular Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/popular.json'))).tvSeriesList;

    test('Should return list of Tv series', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/popular.json'), 200));
      // act
      final result = await dataSource.getPopularTvSeries();
      // assert
      expect(result, equals(tTvSeriesList));
    });
    test('Should return Server Exception', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/popular.json'), 404));
      // act
      final result = dataSource.getPopularTvSeries();
      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });

  });

}
