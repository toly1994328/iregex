import 'package:flutter/material.dart';

import '../model/nav_tab.dart';
import 'nav_tab_item.dart';

class LeftTabNavigation extends StatelessWidget {
  final double width;
  final int activeId;
  final List<NavTab> items;
  final ValueChanged<NavTab> onSelect;

  const LeftTabNavigation({
    Key? key,
    this.width = 22,
    required this.activeId,
    required this.onSelect,
    required this.items,
  }) : super(key: key);

  Iterable<NavTab> get upTabs => items.where((e) => e.down == false);
  Iterable<NavTab> get downTabs => items.where((e) => e.down == true);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: const Color(0xffF2F2F2),
          width: width,
          child: Column(
            children: [
              ...buildNavByType(upTabs),
              const Spacer(),
              ...buildNavByType(downTabs),
            ],
          ),
        ),
        const VerticalDivider(width: 1, color: Color(0xffD1D1D1)),
      ],
    );
  }

  Iterable<Widget> buildNavByType(Iterable<NavTab> tabs) {
    return tabs.map((NavTab tab) => NavTabItem(
          active: activeId == tab.id,
          navTab: tab,
          onTap: onSelect,
        ));
  }
}

