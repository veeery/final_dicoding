import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/detail_tv_series/detail_tv_series_bloc.dart';
import 'package:tv/presentation/bloc/recommendation_tv/recommendation_tv_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:tv/presentation/pages/detail_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

// Detail Tv Series
class MockDetailTvBloc extends MockBloc<DetailTvSeriesEvent, DetailTvSeriesState> implements DetailTvSeriesBloc {}

class FakeDetailTvSeriesEvent extends Fake implements DetailTvSeriesEvent {}

class FakeDetailTvSeriesState extends Fake implements DetailTvSeriesEvent {}

// Recommendation
class MockRecommendationTvBloc extends MockBloc<RecommendationTvEvent, RecommendationTvState>
    implements RecommendationTvBloc {}

class FakeRecommendationTvEvent extends Fake implements RecommendationTvEvent {}

class FakeRecommendationTvState extends Fake implements RecommendationTvEvent {}

// Watchlist
class MockWatchlistTvBloc extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}

class FakeWatchlistTvSeriesEvent extends Fake implements WatchlistTvSeriesEvent {}

class FakeWatchlistTvSeriesState extends Fake implements WatchlistTvSeriesEvent {}

void main() {
  late MockDetailTvBloc mockBloc;
  late MockRecommendationTvBloc mockRecommendationTvBloc;
  late MockWatchlistTvBloc mockWatchlistTvBloc;
  const tId = 1;

  setUpAll(() {
    // Detail
    registerFallbackValue(FakeDetailTvSeriesState());
    registerFallbackValue(FakeDetailTvSeriesEvent());
    // Recommendation
    registerFallbackValue(FakeRecommendationTvEvent());
    registerFallbackValue(FakeRecommendationTvState());
    // Watchlist
    registerFallbackValue(FakeWatchlistTvSeriesEvent());
    registerFallbackValue(FakeWatchlistTvSeriesState());
  });

  setUp(() {
    mockBloc = MockDetailTvBloc();
    mockRecommendationTvBloc = MockRecommendationTvBloc();
    mockWatchlistTvBloc = MockWatchlistTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(providers: [
      BlocProvider<DetailTvSeriesBloc>.value(value: mockBloc),
      BlocProvider<RecommendationTvBloc>.value(value: mockRecommendationTvBloc),
      BlocProvider<WatchlistTvSeriesBloc>.value(value: mockWatchlistTvBloc),
    ], child: MaterialApp(home: body));
  }

  
  group('TV Series Detail Page', () {
    testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(DetailTvSeriesLoading());
      when(() => mockWatchlistTvBloc.state).thenReturn(WatchlistTvSeriesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const DetailTvPage(id: tId)));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(DetailTvSeriesError(message: 'Error Message'));
      when(() => mockRecommendationTvBloc.state).thenReturn(RecommendationTvError(message: 'Error Message'));
      when(() => mockWatchlistTvBloc.state).thenReturn(WatchlistTvSeriesError(message: 'Error Message'));
      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const DetailTvPage(id: tId)));

      expect(textFinder, findsOneWidget);
    });

  });

  group('Tv Detail, Recommendation State & Watchlist Status', () {
    testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(DetailTvSeriesLoaded(result: tTvSeriesDetail));
      when(() => mockRecommendationTvBloc.state).thenReturn(RecommendationTvLoaded(recommendationList: const [tTvSeries]));
      when(() => mockWatchlistTvBloc.state).thenReturn(WatchlistTvSeriesLoaded(result: const [tTvSeries]));

      final result = find.byKey(const Key('build_tv_recommendations'));

      await tester.pumpWidget(makeTestableWidget(const DetailTvPage(id: tId)));

      expect(result, findsOneWidget);
    });
  });
  




}
