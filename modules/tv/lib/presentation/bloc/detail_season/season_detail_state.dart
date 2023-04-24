part of 'season_detail_bloc.dart';

abstract class SeasonDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class SeasonDetailEmpty extends SeasonDetailState {}

class SeasonDetailLoading extends SeasonDetailState {}

class SeasonDetailLoaded extends SeasonDetailState {
  final SeasonDetail result;

  SeasonDetailLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class SeasonDetailError extends SeasonDetailState {
  final String message;

  SeasonDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
