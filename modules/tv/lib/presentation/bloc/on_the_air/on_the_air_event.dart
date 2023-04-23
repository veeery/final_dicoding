part of 'on_the_air_bloc.dart';

abstract class OnTheAirEvent extends Equatable {
  const OnTheAirEvent();
}

class FetchOnTheAir extends OnTheAirEvent {
  @override
  List<Object> get props => [];
}