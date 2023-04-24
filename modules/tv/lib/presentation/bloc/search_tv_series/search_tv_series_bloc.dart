import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/search_tv_series.dart';

part 'search_tv_series_event.dart';

part 'search_tv_series_state.dart';

class SearchTvSeriesBloc extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries searchTvSeries;

  SearchTvSeriesBloc({required this.searchTvSeries}) : super(SearchTvSeriesEmpty()) {
    on<FetchSearchTvSeries>((event, emit) async {
      emit(SearchTvSeriesLoading());

      final result = await searchTvSeries.execute(query: event.query);

      result.fold(
        (l) => emit(SearchTvSeriesError(message: l.message)),
        (r) => r.isEmpty ? emit(SearchTvSeriesEmpty()) : emit(SearchTvSeriesLoaded(result: r)),
      );
    });
  }
}
