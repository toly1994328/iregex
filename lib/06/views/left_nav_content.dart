import 'package:flutter/material.dart';
import '../app/res/cons.dart';
import '../app/res/gap.dart';
import '../components/draggable_panel.dart';

class LeftNavContent extends StatefulWidget {
  final int activeIndex;
  const LeftNavContent({Key? key, this.activeIndex=0}) : super(key: key);

  @override
  State<LeftNavContent> createState() => _LeftNavContentState();
}

class _LeftNavContentState extends State<LeftNavContent> {
  String get name =>Cons.leftNav.firstWhere((e) => e.id==widget.activeIndex).name;

  double _width = 160;

  @override
  Widget build(BuildContext context) {
    if(widget.activeIndex==0) return const SizedBox();
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: _width,
          color: Colors.white,
          child: Text(name),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.resizeColumn,
          child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanUpdate: _changeWidth,
              child: const VerticalDivider(width: 4, color: Color(0xffD1D1D1))),
        ),
      ],
    );
  }

  void _changeWidth(DragUpdateDetails details) {
    setState(() {
      _width += details.delta.dx;
    });
  }
}
