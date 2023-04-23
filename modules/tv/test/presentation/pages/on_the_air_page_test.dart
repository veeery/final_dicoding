import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:tv/presentation/pages/on_the_air_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockOnTheAirBloc extends MockBloc<OnTheAirEvent, OnTheAirState> implements OnTheAirBloc {}

class FakeOnTheAirEvent extends Fake implements OnTheAirEvent {}

class FakeOnTheAirState extends Fake implements OnTheAirEvent {}


void main() {
  late MockOnTheAirBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeOnTheAirEvent());
    registerFallbackValue(FakeOnTheAirState());
  });

  setUp(() {
    mockBloc = MockOnTheAirBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(OnTheAirLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const OnTheAirPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(OnTheAirLoaded(tvSeriesList: const [tTvSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const OnTheAirPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(OnTheAirError(message: 'Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const OnTheAirPage()));

    expect(textFinder, findsOneWidget);
  });

}