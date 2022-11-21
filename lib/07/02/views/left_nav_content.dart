import 'package:flutter/material.dart';

import '../app/res/cons.dart';
import '../repository/impl/db/model/record.dart';
import 'record/record_panel.dart';

class LeftNavContent extends StatefulWidget {
  final int activeIndex;
  final int activeRecordId;
  final List<Record> records;
  final ValueChanged<Record> onTap;


  const LeftNavContent({Key? key, this.activeIndex = 0,
  required this.activeRecordId,
  required this.records,
  required this.onTap,
  }) : super(key: key);

  @override
  State<LeftNavContent> createState() => _LeftNavContentState();
}

class _LeftNavContentState extends State<LeftNavContent> {
  String get name =>
      Cons.leftNav.firstWhere((e) => e.id == widget.activeIndex).name;

  double _width = 180;

  @override
  void initState() {
    print("======_LeftNavContentState#initState========");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.activeIndex == 0) return const SizedBox();
    Widget? child;
    switch(widget.activeIndex){
      case 1:
        child =  RecordPanel(
          onSelectRecord: widget.onTap,
          records: widget.records,
          activeId: widget.activeRecordId,
        );
        break;
    }
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: _width,
          color: Colors.white,
          child: child,
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
