import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/utils.dart';

class NavTab extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String text;
  final int selectedIndex;
  final void Function() onTap;
  final bool isSelected;
  const NavTab({
    super.key,
    required this.icon,
    required this.selectedIcon,
    required this.text,
    required this.selectedIndex,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: selectedIndex == 0
                ? Colors.black
                : isDarkMode(context)
                    ? Colors.grey.shade800
                    : Colors.grey.shade200,
          ),
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.6,
            duration: const Duration(
              microseconds: 300,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: selectedIndex == 0 ? Colors.white : null,
                ),
                Gaps.v5,
                Text(
                  text,
                  style: TextStyle(
                    color: selectedIndex == 0 ? Colors.white : null,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
