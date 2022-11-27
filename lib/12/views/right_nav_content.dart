import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexp/07/06/views/record/bloc/record_bloc.dart';
import 'package:regexp/12/views/link_regex/bloc/link_regex_bloc.dart';

import '../app/res/cons.dart';
import '../repository/impl/db/model/record.dart';
import 'link_regex/views/link_regex_panel.dart';
import 'match/views/match_panel.dart';
import 'record/record_panel.dart';

class RightNavContent extends StatefulWidget {
  final int activeIndex;
  final PageController controller;

  const RightNavContent({
    Key? key,
    this.activeIndex = 0,
    required this.controller,
  }) : super(key: key);

  @override
  State<RightNavContent> createState() => _RightNavContentState();
}

class _RightNavContentState extends State<RightNavContent> {
  String get name {
    if(widget.activeIndex==0){
      return "";
    }
    return Cons.navTabs.firstWhere((e) => e.id == widget.activeIndex).name;
  }

  double _width = 180;

  @override
  void initState() {
    print("======_LeftNavContentState#initState========");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.activeIndex != 0)
          MouseRegion(
            cursor: SystemMouseCursors.resizeColumn,
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanUpdate: _changeWidth,
                child:
                const VerticalDivider(width: 2, color: Color(0xffD1D1D1))),
          ),
        Container(
          alignment: Alignment.center,
          width: widget.activeIndex == 0 ? 0 : _width,
          color: Colors.white,
          child: _buildPageView(),
        ),
      ],
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: widget.controller,
      children: [
        // RecommendPanel(),
        Center(child: Text("Link Regex")),
        Center(child: Text("NoteBook")),
        Center(child: Text("Help Me")),
      ],
    );
  }

  void _changeWidth(DragUpdateDetails details) {
    setState(() {
      _width -= details.delta.dx;
    });
  }
}
