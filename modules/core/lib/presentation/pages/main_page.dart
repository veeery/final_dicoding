import 'package:about/presentation/about_page.dart';
import 'package:core/common/responsive.dart';
import 'package:core/presentation/pages/trending_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/presentation/widgets/app_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/movie_home_page.dart';
import 'package:tv/presentation/pages/tv_series_home_page.dart';

// This is Dashboard / BottomNavigation with
// Home, Profile
class MainPage extends StatefulWidget {
  static const routeName = '/main-page';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 100.h,
            width: 100.w,
            child: AppDisplayPage(index: index),
          ),
          Positioned(
              bottom: 0,
              width: 100.w,
              child: AppBottomBar(
                index: index,
                onTap: (int i) {
                  setState(() {
                    index = i;
                  });
                },
              ))
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget AppDisplayPage({int index = 0}) {
  switch (index) {
    case 0:
      return const MovieHomePage();
    case 1:
      return const TvSeriesHomePage();
    case 2:
      return const TrendingPage();
    case 3:
      return const WatchlistPage();
    case 4:
      return const AboutPage();
    default:
      return const MovieHomePage();
  }
}
