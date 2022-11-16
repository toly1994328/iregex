import 'package:flutter/material.dart';

import '../model/match_result.dart';

class ToolPanel extends StatefulWidget {
  final ValueNotifier<MatchResult> matchResult;
  final ValueChanged<MatchInfo>? onClickItem;

  const ToolPanel(this.matchResult, {Key? key, this.onClickItem})
      : super(key: key);

  @override
  _ToolPanelState createState() => _ToolPanelState();
}

class _ToolPanelState extends State<ToolPanel> {
  List<String> data = [];
  final ScrollController _ctrl = ScrollController();
  int _selectIndex = 0;

  // type: 0 正则关键字
  // type: 1 位置匹配
  // type: 2 简写规则

  final List<Map<String, dynamic>> helpMap = [
    {
      "type": 0,
      "title": "横向排列",
      "rule": "regExp1regExp2",
      "desc": "内容需连续匹配若干规则"
    },
    {
      "type": 0,
      "title": "重复匹配",
      "rule": "regExp{m,n}",
      "desc": "内容需连续至少匹配 m 次，至多匹配 n 次"
    },
    {
      "type": 0,
      "title": "或分支",
      "rule": "regExp1|regExp2",
      "desc": "内容满足任意一个正则即可匹配"
    },
    {
      "type": 0,
      "title": "单字符或",
      "rule": "[c1c2c3]",
      "desc": "盛放单字符匹配的正则，内容满足任意一个即可匹配"
    },
    {"type": 1, "title": "行首位置", "rule": "^", "desc": "匹配行首位置，注意多行模式的开关区别"},
    {"type": 1, "title": "行尾位置", "rule": r"$", "desc": "匹配行尾位置，注意多行模式的开关区别"},
    {
      "type": 1,
      "title": "正则位置(前)",
      "rule": "(?=regExp)",
      "desc": "符合regExp的前方位置"
    },
    {
      "type": 1,
      "title": "正则位置(后)",
      "rule": "(?<=regExp)",
      "desc": "符合regExp的后方位置"
    },
    {
      "type": 1,
      "title": "非正则位置(前)",
      "rule": "(?!regExp)",
      "desc": "不符合regExp的前方位置"
    },
    {
      "type": 1,
      "title": "非正则位置(后)",
      "rule": "(?<!regExp)",
      "desc": "不符合regExp的后方位置"
    }
  ];

  @override
  void didUpdateWidget(covariant ToolPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectIndex = 0;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '正则语法速查',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Divider(
          height: 1,
        ),
        Expanded(
            child: ListView.separated(
          controller: _ctrl,
          separatorBuilder: (_, index) {
            // MatchInfo info = value.results[index];
            // Color color = colors[value.results[index].matchIndex % colors.length];
            //
            // if (info.end) {
            return const Divider();
            // } else {
            //   return Container(
            //       decoration: BoxDecoration(
            //           border: Border(left: BorderSide(width: 2, color: color))),
            //       child: const Divider(
            //         color: Colors.transparent,
            //         height: 4,
            //       ));
            // }
          },
          itemBuilder: (_, index) {
            Map<String, dynamic> item = helpMap[index];
            return Container(
              margin: EdgeInsets.only(top: index == 0 ? 8 : 0),
              padding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        item['title'],
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        '${item['rule']}',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      )
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 4 ),
                  //   child: ,
                  // ),
                  // if (matchInfo.enable)
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Text(
                      "${item['desc']}",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              // ),
            );
          },
          itemCount: helpMap.length,
        ))
      ],
    );
  }

  List<Color> colors = [Colors.red, Colors.green, Colors.blue];

  Widget _buildByMatchResult(
      BuildContext context, MatchResult value, Widget? child) {
    return ListView.separated(
      controller: _ctrl,
      separatorBuilder: (_, index) {
        MatchInfo info = value.results[index];
        Color color = colors[value.results[index].matchIndex % colors.length];

        if (info.end) {
          return const Divider();
        } else {
          return Container(
              decoration: BoxDecoration(
                  border: Border(left: BorderSide(width: 2, color: color))),
              child: const Divider(
                color: Colors.transparent,
                height: 4,
              ));
        }
      },
      itemBuilder: (_, index) {
        MatchInfo matchInfo = value.results[index];
        int groupNum = matchInfo.groupNum;
        String name = groupNum == 0 ? "Match  $index" : "Group  $groupNum";
        Color color = colors[matchInfo.matchIndex % colors.length];

        Gradient? gradient;
        if (matchInfo.enable) {
          gradient = _selectIndex == index
              ? LinearGradient(
                  colors: [
                    color.withOpacity(0),
                    color.withOpacity(0.1),
                    color.withOpacity(0.2)
                  ],
                )
              : null;
        } else {
          gradient = LinearGradient(
            colors: [
              Colors.grey.withOpacity(0),
              Colors.grey.withOpacity(0.1),
              Colors.grey.withOpacity(0.2)
            ],
          );
        }

        return GestureDetector(
          onTap: matchInfo.enable
              ? () {
                  setState(() {
                    _selectIndex = index;
                  });
                  widget.onClickItem?.call(matchInfo);
                }
              : null,
          child: Container(
            margin: EdgeInsets.only(top: index == 0 ? 8 : 0),
            padding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                gradient: gradient,
                // color: _selectIndex==index?color.withOpacity(0.1):Colors.transparent,
                border: Border(left: BorderSide(width: 2, color: color))),
            child: Wrap(
              // direction: Axis.vertical,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    if (matchInfo.enable)
                      Text(
                        '位置:${matchInfo.startPos}-${matchInfo.endPos}',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "匹配结果: ${matchInfo.content ?? "无匹配"}",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: value.results.length,
    );
  }
}
//(\d{1,4})年(\d{1,2})月(\d{1,2})
