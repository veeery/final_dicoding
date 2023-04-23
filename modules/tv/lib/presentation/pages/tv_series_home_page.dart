import 'package:core/presentation/widgets/app_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:tv/presentation/pages/on_the_air_page.dart';
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
              // Navigator.pushNamed(context, SearchMoviePage.routeName);
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
                    return TvSeriesList(tvSeriesList: state.tvSeriesList);
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
        ],
      ),
    );
  }
}
