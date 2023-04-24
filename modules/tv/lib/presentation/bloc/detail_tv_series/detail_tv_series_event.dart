part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesEvent extends Equatable {
  const DetailTvSeriesEvent();
}

class FetchDetailTvSeries extends DetailTvSeriesEvent {
  final int id;

  const FetchDetailTvSeries({required this.id});

  @override
  List<Object> get props => [id];
}
