import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_top_rated.dart';

part 'top_rated_tv_event.dart';

part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvBloc({required this.getTopRatedTvSeries}) : super(TopRatedTvEmpty()) {
    on<FetchTopRatedTvSeries>((event, emit) async {
      emit(TopRatedTvLoading());

      final result = await getTopRatedTvSeries.execute();

      result.fold(
        (l) => emit(TopRatedTvError(message: l.message)),
        (r) => r.isEmpty ? emit(TopRatedTvEmpty()) : emit(TopRatedTvLoaded(topRatedList: r)),
      );
    });
  }
}
