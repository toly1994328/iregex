import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:regexp/app/iconfont/toly_icon.dart';

import '../model/reg_test_item.dart';

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
  bool isInput = false;

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
                  Text(isInput ? '输入测试内容' : '选择测试内容',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
                ],
              ),
            ),
            Expanded(
              child: buildContent(themeColor, context),
            ),
          ],
        ),
        Positioned(
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  isInput = !isInput;
                });
              },
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: .1, blurRadius: 2, color: themeColor)
                      ],
                      color: themeColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20))),
                  child: Icon(
                    isInput ? TolyIcon.icon_input : TolyIcon.icon_switch,
                    size: 20,
                    color: Colors.white,
                  )),
            ))
      ],
    ));
  }

  Widget buildContent(Color themeColor, BuildContext context) {
    Widget child = isInput
        ? AnimatedSwitcher(
            duration: fadeDuration,
            key: ValueKey<bool>(isInput),
            child: buildInput(themeColor, context),
          )
        : AnimatedSwitcher(
            duration: fadeDuration,
            key: ValueKey<bool>(!isInput),
            child: ListView.builder(
                itemCount: items.length,
                itemExtent: 80,
                itemBuilder: _buildItem),
          );
    return child;
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

  final Duration fadeDuration = const Duration(milliseconds: 200);

  Widget buildInput(Color themeColor, BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(8),
      color: themeColor,
      child: TextField(
        keyboardType: TextInputType.text,
        textAlign: TextAlign.start,
        cursorColor: Colors.black,
        minLines: 40,
        maxLines: 40000,
        style: const TextStyle(fontSize: 14, backgroundColor: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: '请输入文本',
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: themeColor),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: themeColor),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        ),
        onChanged: (str) {
          widget.contentTextCtrl.value =
              RegTestItem(title: '', subtitle: '', content: str);
        },
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
