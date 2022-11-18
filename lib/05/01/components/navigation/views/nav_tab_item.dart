import 'package:flutter/material.dart';

import '../model/nav_tab.dart';

class NavTabItem extends StatelessWidget {
  final double width;
  final NavTab navTab;
  final bool active;
  final ValueChanged<NavTab> onTap;

  const NavTabItem({
    Key? key,
    this.width = 22,
    required this.navTab,
    this.active = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int quarterTurns = 3;
    int iconQuarterTurns = 1;
    Color? itemColor = active ? const Color(0xffBDBDBD) : null;
    const Color iconColor = Color(0xff6E6E6E);
    const TextStyle style = TextStyle(height: 1, fontSize: 11);
    const EdgeInsets padding = EdgeInsets.only(left: 8, right: 8);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(navTab),
      child: Container(
        width: width,
        color: itemColor,
        child: RotatedBox(
          quarterTurns: quarterTurns,
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotatedBox(
                  quarterTurns: iconQuarterTurns,
                  child: Icon(navTab.icon, size: 13, color: iconColor),
                ),
                const SizedBox(width: 5),
                Text(navTab.name, style: style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
