import 'package:flutter/material.dart';
import '../app/res/cons.dart';
import '../app/res/gap.dart';

class LeftNavContent extends StatelessWidget {
  final int activeIndex;
  const LeftNavContent({Key? key, this.activeIndex=0}) : super(key: key);

  String get name =>Cons.leftNav.firstWhere((e) => e.id==activeIndex).name;

  @override
  Widget build(BuildContext context) {
    if(activeIndex==0) return const SizedBox();
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 160,
          child: Text(name),
        ),
        Gap.dividerV
      ],
    );
  }
}
