import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:regexp/05/play_regexp_v2/model/reg_test_item.dart';
import 'package:regexp/app/iconfont/toly_icon.dart';

class SwitchEndDrawer extends StatefulWidget {
  final ValueNotifier<RegTestItem> contentTextCtrl;

  const SwitchEndDrawer({Key? key, required this.contentTextCtrl})
      : super(key: key);

  @override
  _SwitchEndDrawerState createState() => _SwitchEndDrawerState();
}

class _SwitchEndDrawerState extends State<SwitchEndDrawer> {
  List<RegTestItem> items = [];
  int _position = 0;

  @override
  void initState() {
    super.initState();
    _loadTestData();
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;
    return Drawer(
        child: Stack(
      children: [
        Column(
          children: [
            Container(
              height: 56,
              alignment: Alignment.center,
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    TolyIcon.icon_text,
                    color: themeColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('选择测试内容',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemExtent: 80,
                  itemBuilder: _buildItem),
            ),
          ],
        ),
        Positioned(
            right: 0,
            child: InkWell(
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: .1, blurRadius: 2, color: themeColor)
                      ],
                      color: themeColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20))
                      ),
                  child: const Icon(
                    TolyIcon.icon_switch,
                    size: 20,
                    color: Colors.white,
                  )),
            ))
      ],
    ));
  }

  void _loadTestData() async {
    String dataStr = await rootBundle.loadString('assets/data.json');
    items = json
        .decode(dataStr)
        .map<RegTestItem>((e) => RegTestItem.fromJson((e)))
        .toList();
    _position = items.indexWhere(
        (element) => element.title == widget.contentTextCtrl.value.title);
    if (mounted) setState(() {});
  }

  Widget _buildItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        print('=======${items[index].title}====');
        widget.contentTextCtrl.value = items[index];
        setState(() {
          _position = index;
        });
      },
      child: RegTestWidget(
        active: _position == index,
        item: items[index],
      ),
    );
  }
}

class RegTestWidget extends StatelessWidget {
  final RegTestItem item;
  final bool active;

  const RegTestWidget({Key? key, required this.item, this.active = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: active
            ? Theme.of(context).primaryColor.withOpacity(0.1)
            : Colors.white,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text('${item.title}',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text('${item.subtitle}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              ],
            ),
            Text(
              '${item.content}',
              maxLines: 2,
              style: TextStyle(fontSize: 12, color: Color(0xffCECBCD)),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ));
  }
}
