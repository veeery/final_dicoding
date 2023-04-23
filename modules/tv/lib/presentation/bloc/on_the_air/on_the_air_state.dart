part of 'on_the_air_bloc.dart';

abstract class OnTheAirState extends Equatable {
  @override
  List<Object> get props => [];
}

class OnTheAirEmpty extends OnTheAirState {}

class OnTheAirLoading extends OnTheAirState {}

class OnTheAirLoaded extends OnTheAirState {
  final List<TvSeries> tvSeriesList;

  OnTheAirLoaded({required this.tvSeriesList});

  @override
  List<Object> get props => [tvSeriesList];
}

class OnTheAirError extends OnTheAirState {
  final String message;

  OnTheAirError({required this.message});

  @override
  List<Object> get props => [message];
}
