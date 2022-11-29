import 'package:flutter/material.dart';

import '../model/nav_tab.dart';

class NavTabItem extends StatelessWidget {
  final double width;
  final NavTab navTab;
  final bool active;
  final ValueChanged<NavTab> onTap;
  final TextDirection? textDirection;

  const NavTabItem({
    super.key,
    this.width = 22,
    this.textDirection,
    required this.navTab,
    this.active = false,
    required this.onTap,
  });



  @override
  Widget build(BuildContext context) {
    bool right = textDirection !=null&&textDirection==TextDirection.rtl;
    int quarterTurns = right?1:3;
    int iconQuarterTurns = right?3:1;
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
