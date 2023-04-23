import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';

@GenerateMocks([
  TvSeriesRepository,
  TvRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
