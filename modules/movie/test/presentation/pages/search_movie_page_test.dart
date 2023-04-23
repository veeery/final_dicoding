import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie/presentation/pages/search_movie_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchMovieBloc extends MockBloc<SearchMoviesEvent, SearchMoviesState> implements SearchMoviesBloc {}

class FakeSearchMoviesEvent extends Fake implements SearchMoviesEvent {}

class FakeSearchMoviesState extends Fake implements SearchMoviesEvent {}

void main() {
  late MockSearchMovieBloc mockSearchMovieBloc;

  setUpAll(() {
    registerFallbackValue(FakeSearchMoviesEvent());
    registerFallbackValue(FakeSearchMoviesState());
  });

  setUp(() {
    mockSearchMovieBloc = MockSearchMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchMoviesBloc>.value(
      value: mockSearchMovieBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(SearchMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(SearchMoviesLoaded(result: [testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(SearchMoviesError(message: 'Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should triggered onSubmitted or onChanged when clicked or OK', (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(SearchMoviesLoaded(result: [testMovie]));

    final onSubmittedFinder = find.byType(TextField);

    await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));
    await tester.enterText(onSubmittedFinder, 'abc');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    
    expect(find.text('abc'), findsOneWidget);
    
  });
}
