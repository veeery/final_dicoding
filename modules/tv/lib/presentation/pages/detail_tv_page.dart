import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/detail_tv_series/detail_tv_series_bloc.dart';
import 'package:tv/presentation/bloc/recommendation_tv/recommendation_tv_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:tv/presentation/widgets/tv_detail_content.dart';

class DetailTvPage extends StatefulWidget {
  static const routeName = '/detail-tv-page';
  final int id;

  const DetailTvPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailTvPage> createState() => _DetailTvPageState();
}

class _DetailTvPageState extends State<DetailTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailTvSeriesBloc>().add(FetchDetailTvSeries(id: widget.id));
      context.read<RecommendationTvBloc>().add(FetchRecommendationTvSeries(id: widget.id));
      context.read<WatchlistTvSeriesBloc>().add(LoadWatchlistStatusEvent(tvSeriesId: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);

    bool isWatchlist = context.select<WatchlistTvSeriesBloc, bool>(
      (value) => (value.state is WatchlistTvSeriesStatus) ? (value.state as WatchlistTvSeriesStatus).isAdded : false,
    );

    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries());
          return Future.value(true);
        },
        child: BlocBuilder<DetailTvSeriesBloc, DetailTvSeriesState>(
          builder: (context, state) {
            if (state is DetailTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DetailTvSeriesLoaded) {
              return TvDetailContent(state.result, isWatchlist);
            } else if (state is DetailTvSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Empty data'),
              );
            }
          },
        ),
      ),
    );
  }
}
