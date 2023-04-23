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
}
