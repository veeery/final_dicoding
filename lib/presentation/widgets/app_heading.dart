import 'package:dicoding_final_ditonton/common/responsive.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';

class AppHeading extends StatelessWidget {
  final String title;
  final Widget child;
  final Function()? onTap;

  AppHeading({
    required this.title,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buildSubHeading(title: title, onTap: onTap), child],
    );
  }

  Row buildSubHeading({required String title, Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Text(
              title,
              style: kHeading6,
            )),
        onTap == null
            ? Container()
            : InkWell(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: Row(
                    children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
                  ),
                ),
              ),
      ],
    );
  }
}
