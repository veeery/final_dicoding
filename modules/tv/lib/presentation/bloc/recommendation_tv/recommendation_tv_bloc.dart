import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTvBloc extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetRecommendationTvSeries getRecommendationTvSeries;

  RecommendationTvBloc({required this.getRecommendationTvSeries}) : super(RecommendationTvEmpty()) {
    on<FetchRecommendationTvSeries>((event, emit) async {
      emit(RecommendationTvLoading());

      final result = await getRecommendationTvSeries.execute(id: event.id);

      result.fold(
        (l) => emit(RecommendationTvError(message: l.message)),
        (r) => r.isEmpty ? emit(RecommendationTvEmpty()) : emit(RecommendationTvLoaded(recommendationList: r)),
      );
    });
  }
}
