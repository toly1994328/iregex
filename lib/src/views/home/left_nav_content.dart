import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexp/07/06/views/record/bloc/record_bloc.dart';

import '../../app/res/cons.dart';
import '../../models/record/record.dart';
import '../match/match_panel.dart';
import '../record/record_panel.dart';

class LeftNavContent extends StatefulWidget {
  final int activeIndex;
  final PageController controller;

  const LeftNavContent({
    Key? key,
    this.activeIndex = 0,
    required this.controller,
  }) : super(key: key);

  @override
  State<LeftNavContent> createState() => _LeftNavContentState();
}

class _LeftNavContentState extends State<LeftNavContent> {
  String get name =>
      Cons.navTabs.firstWhere((e) => e.id == widget.activeIndex).name;

  double _width = 180;

  @override
  void initState() {
    print("======_LeftNavContentState#initState========");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NavigationRailThemeData data = Theme.of(context).navigationRailTheme;

    Color? color = data.backgroundColor;
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: widget.activeIndex == 0 ? 0 : _width,
          color: color,
          child: _buildPageView(),
        ),
        if (widget.activeIndex != 0)
          MouseRegion(
            cursor: SystemMouseCursors.resizeColumn,
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanUpdate: _changeWidth,
                child:
                    const VerticalDivider(width: 2)),
          ),
      ],
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: widget.controller,
      children: [
        RecordPanel(),
        const MatchPanel(),
        const Center(child: Text("Favorites")),
      ],
    );
  }

  void _changeWidth(DragUpdateDetails details) {
    setState(() {
      _width += details.delta.dx;
    });
  }
}
