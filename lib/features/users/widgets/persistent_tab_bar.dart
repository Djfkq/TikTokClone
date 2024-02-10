import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/utils.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode(context) ? Colors.black : Colors.white,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: isDarkMode(context)
                  ? Colors.grey.shade800
                  : Colors.grey.shade300,
              width: 0.5,
            ),
          ),
        ),
        child: const TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size20,
              ),
              child: Icon(
                Icons.grid_4x4_rounded,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size20,
              ),
              child: FaIcon(
                FontAwesomeIcons.heart,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 30;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
