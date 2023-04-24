import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/season_detail.dart';
import 'package:tv/domain/usecases/get_season_detail.dart';

part 'season_detail_event.dart';
part 'season_detail_state.dart';

class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  final GetSeasonDetail getSeasonDetail;

  SeasonDetailBloc({required this.getSeasonDetail}) : super(SeasonDetailEmpty()) {
    on<FetchSeasonDetail>((event, emit) async {
      emit(SeasonDetailLoading());

      final result = await getSeasonDetail.execute(
        id: event.id,
        seasonNumber: event.seasonNumber,
      );

      result.fold((l) => emit(SeasonDetailError(message: l.message)), (r) => emit(SeasonDetailLoaded(result: r)));
    });
  }
}
