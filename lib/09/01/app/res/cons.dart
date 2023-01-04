import 'package:flutter/material.dart';
import 'package:regexp/src/app/iconfont/toly_icon.dart';
import '../../components/navigation/model/nav_tab.dart';



class Cons {
  static List<NavTab> leftNav = const [
    NavTab(id: 1, name: 'Examples', icon: TolyIcon.icon_dir),
    NavTab(id: 2, name: 'Matches', icon: TolyIcon.icon_dot_all),
    NavTab(id: 3, name: 'Input Panel', icon: TolyIcon.icon_input, down: true),
    NavTab(id: 4, name: 'Recommend', icon: Icons.lightbulb_outline, down: true),
  ];
}
