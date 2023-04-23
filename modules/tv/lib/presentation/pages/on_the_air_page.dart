import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:tv/presentation/widgets/tv_series_card.dart';

class OnTheAirPage extends StatefulWidget {
  static const routeName = '/on-the-air';

  const OnTheAirPage({Key? key}) : super(key: key);

  @override
  State<OnTheAirPage> createState() => _OnTheAirPageState();
}

class _OnTheAirPageState extends State<OnTheAirPage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<OnTheAirBloc>().add(FetchOnTheAir());
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
        child: BlocBuilder<OnTheAirBloc, OnTheAirState>(
          builder: (context, state) {
            if (state is OnTheAirLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OnTheAirLoaded) {
              return ListView.builder(
                itemCount: state.tvSeriesList.length,
                itemBuilder: (context, index) {
                  final tvSeries = state.tvSeriesList[index];
                  return TvSeriesCard(tvSeries: tvSeries);
                },
              );
            } else if (state is OnTheAirError) {
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
