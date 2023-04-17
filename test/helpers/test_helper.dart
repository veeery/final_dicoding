import 'package:dicoding_final_ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:dicoding_final_ditonton/domain/repositories/movie_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
