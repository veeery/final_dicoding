import 'package:core/common/app_curve_size.dart';
import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  final int index;
  final Function(int) onTap;

  AppBottomBar({required this.onTap, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(CurveSize.mediumCurve),
          topRight: Radius.circular(CurveSize.mediumCurve),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              splashColor: Colors.cyan[400],
              splashRadius: CurveSize.mediumCurve,
              onPressed: () => onTap(0),
              icon: Icon(
                Icons.movie_rounded,
                color: index == 0 ? Colors.cyan : Colors.grey[400],
              )),
          IconButton(
              splashColor: Colors.cyan[400],
              splashRadius: CurveSize.mediumCurve,
              onPressed: () => onTap(1),
              icon: Icon(
                Icons.bookmark,
                color: index == 1 ? Colors.red : Colors.grey[400],
              )),
          // IconButton(
          //     splashColor: Colors.cyan[400],
          //     splashRadius: 500,
          //     onPressed: () => onTap(1),
          //     icon: Icon(
          //       Icons.local_fire_department_sharp,
          //       color: index == 1 ? Colors.red : Colors.grey[400],
          //     )),
          // IconButton(
          //     splashColor: Colors.cyan[400],
          //     splashRadius: 500,
          //     onPressed: () => onTap(2),
          //     icon: Icon(
          //       Icons.bookmark_outline_rounded,
          //       color: index == 2 ? Colors.cyan : Colors.grey[400],
          //     )),
          // IconButton(
          //     splashColor: Colors.cyan[400],
          //     splashRadius: 500,
          //     onPressed: () => onTap(3),
          //     icon: Icon(
          //       Icons.settings_rounded,
          //       color: index == 3 ? Colors.cyan : Colors.grey[400],
          //     )),
        ],
      ),
    );
  }
}
