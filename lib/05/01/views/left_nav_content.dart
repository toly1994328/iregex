import 'package:flutter/material.dart';
import '../app/res/cons.dart';
import '../app/res/gap.dart';

class LeftNavContent extends StatefulWidget {
  final int activeIndex;
  const LeftNavContent({Key? key, this.activeIndex=0}) : super(key: key);

  @override
  State<LeftNavContent> createState() => _LeftNavContentState();
}

class _LeftNavContentState extends State<LeftNavContent> {

  @override
  Widget build(BuildContext context) {
    if(widget.activeIndex==0) return const SizedBox();
    // switch(activeIndex){
    //   case 1:
    //
    // }
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 160,
          child: Text(Cons.leftNav.firstWhere((element) => element.id==widget.activeIndex).name),
        ),
        Gap.dividerV
      ],
    );
  }
}
