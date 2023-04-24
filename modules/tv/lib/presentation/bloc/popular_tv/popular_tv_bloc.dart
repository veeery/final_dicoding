import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_popular.dart';

part 'popular_tv_event.dart';

part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvBloc({required this.getPopularTvSeries}) : super(PopularTvEmpty()) {
    on<FetchPopularTvSeries>((event, emit) async {
      emit(PopularTvLoading());

      final result = await getPopularTvSeries.execute();

      result.fold(
        (l) => emit(PopularTvError(message: l.message)),
        (r) => r.isEmpty ? emit(PopularTvEmpty()) : emit(PopularTvLoaded(popularTvList: r)),
      );
    });
  }
}
