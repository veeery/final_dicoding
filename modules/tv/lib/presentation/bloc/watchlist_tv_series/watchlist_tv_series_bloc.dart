import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv/domain/usecases/save_tv_watchlist.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;
  final GetWatchlistTvSeriesStatus getWatchlistTvSeriesStatus;
  final SaveTvSeriesWatchlist saveTvSeriesWatchlist;
  final RemoveTvSeriesWatchlist removeTvSeriesWatchlist;

  WatchlistTvSeriesBloc({
    required this.getWatchlistTvSeries,
    required this.getWatchlistTvSeriesStatus,
    required this.saveTvSeriesWatchlist,
    required this.removeTvSeriesWatchlist,
  }) : super(WatchlistTvSeriesEmpty()) {
    // Fetch Tv Series Watchlist
    on<FetchWatchlistTvSeries>((event, emit) async {
      emit(WatchlistTvSeriesLoading());

      final result = await getWatchlistTvSeries.execute();

      result.fold((l) {
        emit(WatchlistTvSeriesError(message: l.message));
      }, (r) {
        r.isEmpty ? emit(WatchlistTvSeriesEmpty()) : emit(WatchlistTvSeriesLoaded(result: r));
      });
    });

    // Fetch Status (isAdded or Not)
    on<LoadWatchlistStatusEvent>((event, emit) async {
      final int id = event.tvSeriesId;
      final result = await getWatchlistTvSeriesStatus.execute(id: id);
      emit(WatchlistTvSeriesStatus(isAdded: result));
    });

    // Save Watchlist
    on<SaveWatchlistTvEvent>((event, emit) async {
      final tv = event.tvSeriesDetail;
      emit(WatchlistTvSeriesLoading());
      final result = await saveTvSeriesWatchlist.execute(tvSeriesDetail: tv);

      result.fold(
        (l) => emit(WatchlistTvSeriesError(message: l.message)),
        (r) => emit(WatchlistTvSeriesStatus(isAdded: true)),
      );
    });

    // Remove watchlist
    on<RemoveWatchlistTvEvent>((event, emit) async {
      final tv = event.tvSeriesDetail;
      emit(WatchlistTvSeriesLoading());
      final result = await removeTvSeriesWatchlist.execute(tvSeriesDetail: tv);

      result.fold(
        (l) => emit(WatchlistTvSeriesError(message: l.message)),
        (r) => emit(WatchlistTvSeriesStatus(isAdded: false)),
      );
    });
  }
}
