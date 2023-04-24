import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';
import 'package:tv/domain/usecases/get_detail_tv_series.dart';

part 'detail_tv_series_event.dart';

part 'detail_tv_series_state.dart';

class DetailTvSeriesBloc extends Bloc<DetailTvSeriesEvent, DetailTvSeriesState> {
  final GetDetailTvSeries getDetailTvSeries;

  DetailTvSeriesBloc({required this.getDetailTvSeries}) : super(DetailTvSeriesEmpty()) {
    on<FetchDetailTvSeries>((event, emit) async {
      emit(DetailTvSeriesLoading());

      final result = await getDetailTvSeries.execute(id: event.id);

      result.fold(
        (l) => emit(DetailTvSeriesError(message: l.message)),
        (r) => emit(DetailTvSeriesLoaded(result: r)),
      );
    });
  }
}
