import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/recommendations/movie_recommendations_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

// Detail Movie
class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState> implements MovieDetailBloc {}

class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailEvent {}

// Recommendation
class MockMovieRecommendationBloc extends MockBloc<MovieRecommendationsEvent, MovieRecommendationsState>
    implements MovieRecommendationsBloc {}

class FakeMovieRecommendationEvent extends Fake implements MovieRecommendationsEvent {}

class FakeMovieRecommendationState extends Fake implements MovieRecommendationsEvent {}

// Watchlist
class MockWatchlistMovieBloc extends MockBloc<WatchlistMovieEvent, WatchlistMovieState> implements WatchlistMovieBloc {}

class FakeWatchlistMovieState extends Fake implements WatchlistMovieEvent {}

class FakeWatchlistMovieEvent extends Fake implements WatchlistMovieEvent {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUpAll(() {
    // Movie Detail
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    // Movie Recommendation
    registerFallbackValue(FakeMovieRecommendationEvent());
    registerFallbackValue(FakeMovieRecommendationState());
    // Watchlist Attributes
    registerFallbackValue(FakeWatchlistMovieState());
    registerFallbackValue(FakeWatchlistMovieEvent());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(providers: [
      BlocProvider<MovieDetailBloc>.value(
        value: mockMovieDetailBloc,
      ),
      BlocProvider<MovieRecommendationsBloc>.value(
        value: mockMovieRecommendationBloc,
      ),
      BlocProvider<WatchlistMovieBloc>.value(
        value: mockWatchlistMovieBloc,
      ),
    ], child: MaterialApp(home: body));
  }

  int tId = 1;

  group('Movie Detail Page', () {
    testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
      when(() => mockWatchlistMovieBloc.state).thenReturn(WatchlistMovieLoading());
      when(() => mockMovieRecommendationBloc.state).thenReturn(MovieRecommendationLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: tId)));
      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailError(message: 'Error Message'));
      when(() => mockMovieRecommendationBloc.state).thenReturn(MovieRecommendationError(message: 'Error Message'));
      when(() => mockWatchlistMovieBloc.state).thenReturn(WatchlistMovieError(message: 'Error Message'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: tId)));

      expect(textFinder, findsOneWidget);
    });
  });

  group('Movie Detail, Recommendation State & Watchlist Status', () {
    testWidgets('Page should return MovieDetail & Recommendation with Watchlist status TRUE',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoaded(movieDetail: testMovieDetail));
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoaded(movieRecommendation: [testMovie]));
      when(() => mockWatchlistMovieBloc.state).thenReturn(WatchlistMovieStatus(isAdded: true));

      final result = find.byKey(const Key('build_movie_recommendations'));

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: tId)));

      expect(result, findsOneWidget);
    });

    testWidgets('Page should return MovieDetail & Recommendation with Watchlist status FALSE',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoaded(movieDetail: testMovieDetail));
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoaded(movieRecommendation: [testMovie]));
      when(() => mockWatchlistMovieBloc.state).thenReturn(WatchlistMovieStatus(isAdded: false));

      final result = find.byKey(const Key('build_movie_recommendations'));

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: tId)));

      expect(result, findsOneWidget);
    });

    testWidgets('Page should triggered when back', (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoaded(movieDetail: testMovieDetail));
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoaded(movieRecommendation: [testMovie]));
      when(() => mockWatchlistMovieBloc.state).thenReturn(WatchlistMovieStatus(isAdded: false));

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: tId)));

      final popScopeFinder = find.byKey(const Key('willPopScope_movie'));

      await tester.pageBack();
      expect(popScopeFinder, findsOneWidget);


    });

    testWidgets('Page should return SnackBar Message', (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoaded(movieDetail: testMovieDetail));
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoaded(movieRecommendation: [testMovie]));
      when(() => mockWatchlistMovieBloc.state).thenReturn(WatchlistMovieStatus(isAdded: false));

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: tId)));
      final snackBarTextFinder = find.text('Added to Watchlist');
      expect(snackBarTextFinder, findsNothing);

      await tester.tap(find.byKey(const Key('watchlist_button')));
      expect(snackBarTextFinder, findsNothing);
      await tester.pump();
      expect(snackBarTextFinder, findsOneWidget);
    });



  });
}
