import 'package:flutter/material.dart';
import 'rrect_check.dart';

/// create by 张风捷特烈 on 2020-04-07
/// contact me by email 1981462002@qq.com
/// 说明:

typedef BoolWidgetBuilder = Widget Function(
    BuildContext context, int index, bool selected);

class SingleFilter<T> extends StatelessWidget {
  final List<T> data;
  final int activeId;

  final void Function(T index) onItemClick;

   const SingleFilter({Key? key,
    required this.data,
    required this.activeId,
    required this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemExtent: 28,
      children: data.asMap().keys.map((int index) {
        // int recommendIndex = BlocProvider.of<SelectionCubit>(context).state.recommendIndex;
        bool selected = index == activeId;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: ()=> onItemClick.call(data[index]),
          child: Row(
            children: [
              RRectCheck(
                inActiveColor: Color(0xffB0B0B0),
                active: selected,
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(child: Text(data[index].toString()))
            ],
          ),
        );
      }).toList(),
    );
  }
}
