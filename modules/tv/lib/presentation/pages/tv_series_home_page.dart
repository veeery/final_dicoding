import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/common/responsive.dart';
import 'package:core/presentation/widgets/app_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/on_the_air_page.dart';
import 'package:tv/presentation/pages/search_tv_series_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/widgets/tv_series_card.dart';
import 'package:tv/presentation/widgets/tv_series_list.dart';

class TvSeriesHomePage extends StatefulWidget {
  static const routeName = '/tv-series-home-page';

  const TvSeriesHomePage({Key? key}) : super(key: key);

  @override
  State<TvSeriesHomePage> createState() => _TvSeriesHomePageState();
}

class _TvSeriesHomePageState extends State<TvSeriesHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OnTheAirBloc>().add(FetchOnTheAir());
      context.read<TopRatedTvBloc>().add(FetchTopRatedTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvSeriesPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          AppHeading(
              title: 'On The Air',
              onTap: () => Navigator.pushNamed(context, OnTheAirPage.routeName),
              child: BlocBuilder<OnTheAirBloc, OnTheAirState>(
                builder: (context, state) {
                  if (state is OnTheAirLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is OnTheAirLoaded) {
                    return CarouselSlider.builder(
                      itemCount: state.tvSeriesList.length,
                      options: CarouselOptions(
                        height: 35.h,
                        enableInfiniteScroll: false,
                        autoPlayInterval: const Duration(seconds: 2),
                        autoPlay: true,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        // return TvSeriesList(tvSeriesList: state.tvSeriesList);
                        final tvSeries = state.tvSeriesList[index];

                        return TvSeriesCard(
                          tvSeries: tvSeries,
                          isOnCarousel: true,
                        );
                      },
                    );
                  } else if (state is OnTheAirError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: Text('Unknown Error'),
                    );
                  }
                },
              )),
          AppHeading(
              title: 'Top Rated TV Series',
              onTap: () => Navigator.pushNamed(context, TopRatedTvSeriesPage.routeName),
              child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                builder: (context, state) {
                  if (state is TopRatedTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvLoaded) {
                    return TvSeriesList(tvSeriesList: state.topRatedList);
                  } else if (state is TopRatedTvError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: Text('Unknown Error'),
                    );
                  }
                },
              )),
        ],
      ),
    );
  }
}
