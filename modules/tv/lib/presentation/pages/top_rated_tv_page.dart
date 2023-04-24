import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';

import '../widgets/tv_series_card.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const routeName = '/on-the-air';

  const TopRatedTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<TopRatedTvBloc>().add(FetchTopRatedTvSeries());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (context, state) {
            if (state is TopRatedTvLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TopRatedTvLoaded) {
              return ListView.builder(
                itemCount: state.topRatedList.length,
                itemBuilder: (context, index) {
                  final tvSeries = state.topRatedList[index];
                  return TvSeriesCard(tvSeries: tvSeries);
                },
              );
            } else if (state is TopRatedTvError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(child: Text('Unknown Error'));
            }
          },
        ),
      ),
    );
  }
}
