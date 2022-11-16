import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-07
/// contact me by email 1981462002@qq.com
/// 说明: 

typedef BoolWidgetBuilder = Widget Function(BuildContext context,int index, bool selected);

class SingleChipFilter<T> extends StatefulWidget {
  final List<T> data;
  final BoolWidgetBuilder labelBuilder;
  final IndexedWidgetBuilder? avatarBuilder;
  // final Function(List<int>) onChange;
  final void Function(T? t) onSelected;
  final String? label;

  SingleChipFilter({required this.data,required this.labelBuilder,this.avatarBuilder,required this.onSelected,this.label});

  @override
  _SingleChipFilterState createState() => _SingleChipFilterState();
}

class _SingleChipFilterState<T> extends State<SingleChipFilter<T>> {
  final List<int> _selected = <int>[];

  @override
  void didUpdateWidget(covariant SingleChipFilter<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selected.clear();
    _selected.add(0);
  }
  @override
  void initState() {
    super.initState();
    _selected.add(0);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = widget.data.map((e) =>
        _buildChild(context,widget.data.indexOf(e))).toList();

    return Container(
      padding: EdgeInsets.only(left: 10,top: 10),
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if(widget.label!=null)
            Text(widget.label!,style: TextStyle(fontWeight: FontWeight.bold),),
          ...children
        ],
      ),
    );
  }

  Widget _buildChild(BuildContext context,int index) {
    bool selected = _selected.contains(index);
    return FilterChip(
      selectedColor: Colors.orange.withAlpha(55),
      labelPadding: EdgeInsets.only(left: 5,right: 5),
      selectedShadowColor: Colors.blue,
      shadowColor: Colors.orangeAccent,
      pressElevation: 5,
      elevation: 3,
      avatar: widget.avatarBuilder==null?null:widget.avatarBuilder!(context,index),
      label: widget.labelBuilder(context,index,selected),
      selected: selected,
      onSelected: (bool value) {
        setState(() {
          _selected.clear();
          if(!value){
            widget.onSelected(null);
          }else{
            _selected.add(index);
            widget.onSelected(widget.data[_selected.last]);
          }
        });
      },
    );
  }
}
