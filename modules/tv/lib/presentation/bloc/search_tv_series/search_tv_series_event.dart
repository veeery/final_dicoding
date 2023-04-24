part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();
}

class FetchSearchTvSeries extends SearchTvSeriesEvent {

  final String query;

  const FetchSearchTvSeries({required this.query});

  @override
  List<Object> get props => [query];
}
