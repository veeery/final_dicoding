import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/recommendations/movie_recommendations_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState> implements MovieDetailBloc {}

class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailEvent {}

class MockMovieRecommendationBloc extends MockBloc<MovieRecommendationsEvent, MovieRecommendationsState>
    implements MovieRecommendationsBloc {}

class FakeMovieRecommendationEvent extends Fake implements MovieRecommendationsEvent {}

class FakeMovieRecommendationState extends Fake implements MovieRecommendationsEvent {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;

  setUpAll(() {
    // Movie Detail
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    // Movie Recommendation
    registerFallbackValue(FakeMovieRecommendationEvent());
    registerFallbackValue(FakeMovieRecommendationState());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(providers: [
      BlocProvider<MovieDetailBloc>.value(
        value: mockMovieDetailBloc,
      ),
      BlocProvider<MovieRecommendationsBloc>.value(
        value: mockMovieRecommendationBloc,
      ),
    ], child: MaterialApp(home: body));
  }

  int tId = 1;

  group('Movie Detail Page', () {
    testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: tId)));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailError(message: 'Error Message'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: tId)));

      expect(textFinder, findsOneWidget);
    });
  });


  group('Movie Detail & Recommendation State', () {
    testWidgets('Page should display MovieCard & Build Movie Recommendations when data is loaded',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoaded(movieDetail: testMovieDetail));
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoaded(movieRecommendation: [testMovie]));

      final result = find.byKey(const Key('build_movie_recommendations'));

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: tId)));

      expect(result, findsOneWidget);
    });
  });
}
