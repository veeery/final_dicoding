import 'package:core/common/app_curve_size.dart';
import 'package:core/common/app_text_style.dart';
import 'package:core/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:tv/presentation/widgets/tv_series_card.dart';

class SearchTvSeriesPage extends StatefulWidget {
  static const routeName = '/search-page-tv';

  const SearchTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<SearchTvSeriesPage> createState() => _SearchTvSeriesPageState();
}

class _SearchTvSeriesPageState extends State<SearchTvSeriesPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search TV Series'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchTvSeriesBloc>().add(FetchSearchTvSeries(query: query));
              },
              onSubmitted: (query) {
                context.read<SearchTvSeriesBloc>().add(FetchSearchTvSeries(query: query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(CurveSize.smallCurve)),
              ),
              textInputAction: TextInputAction.search,
            ),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Expanded(
              child: BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
                builder: (context, state) {
                  if (state is SearchTvSeriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchTvSeriesLoaded) {
                    return ListView.builder(
                      itemCount: state.result.length,
                      itemBuilder: (context, index) {
                        final tv = state.result[index];
                        return TvSeriesCard(tvSeries: tv);
                      },
                    );
                  } else if (state is SearchTvSeriesError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(child: Text('Empty data'));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
