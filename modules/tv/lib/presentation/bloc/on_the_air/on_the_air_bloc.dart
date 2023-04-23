import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_on_the_air.dart';

part 'on_the_air_event.dart';
part 'on_the_air_state.dart';

class OnTheAirBloc extends Bloc<OnTheAirEvent, OnTheAirState> {
  final GetOnTheAirTvSeries getOnTheAirTvSeries;

  OnTheAirBloc({required this.getOnTheAirTvSeries}) : super(OnTheAirEmpty()) {
    on<OnTheAirEvent>((event, emit) async {
      emit(OnTheAirLoading());

      final result = await getOnTheAirTvSeries.execute();

      result.fold(
        (l) => emit(OnTheAirError(message: l.message)),
        (r) => r.isEmpty ? emit(OnTheAirEmpty()) : emit(OnTheAirLoaded(tvSeriesList: r)),
      );
    });
  }
}
