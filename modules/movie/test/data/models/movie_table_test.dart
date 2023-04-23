import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('Should return a JSON Map containing proper data', () async {
    final result = testMovieTable.toJson();
    final expectedJsonMap = {
      "id": 1,
      "title": "title",
      "posterPath": "posterPath",
      "overview": "overview",
    };

    expect(result, expectedJsonMap);
  });
}
