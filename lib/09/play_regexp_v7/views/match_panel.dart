import 'package:flutter/material.dart';

import '../model/match_result.dart';

class MatchPanel extends StatefulWidget {
  final ValueNotifier<MatchResult> matchResult;
  final ValueChanged<MatchInfo>? onClickItem;

  const MatchPanel(this.matchResult, {Key? key, this.onClickItem})
      : super(key: key);

  @override
  _MatchPanelState createState() => _MatchPanelState();
}

class _MatchPanelState extends State<MatchPanel> {
  List<String> data = [];
  final ScrollController _ctrl = ScrollController();
  int _selectIndex = 0;

  @override
  void didUpdateWidget(covariant MatchPanel oldWidget) {
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
          '匹配组信息',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          height: 1,
        ),
        Expanded(
            child: ValueListenableBuilder(
          valueListenable: widget.matchResult,
          builder: (_, MatchResult value, __) => ListView.separated(
            controller: _ctrl,
            separatorBuilder: (_, index) => _buildSeparator(index, value),
            itemBuilder: (context, index) =>
                _buildGroupItem(context, index, value),
            itemCount: value.results.length,
          ),
        ))
      ],
    );
  }

  List<Color> colors = [Colors.red, Colors.green, Colors.blue];

  Widget _buildGroupItem(
    BuildContext context,
    int index,
    MatchResult value,
  ) {
    MatchInfo matchInfo = value.results[index];
    int groupNum = matchInfo.groupNum;
    String name = groupNum == 0
        ? "Match  ${matchInfo.matchIndex + 1}"
        : "Group  $groupNum";
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

    return InkWell(
      onHover: matchInfo.enable
          ? (_) {
              setState(() {
                _selectIndex = index;
              });
              widget.onClickItem?.call(matchInfo);
            }
          : null,
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
        padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
        decoration: BoxDecoration(
            gradient: gradient,
            border: Border(left: BorderSide(width: 2, color: color))),
        child: Wrap(
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
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
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeparator(int index, MatchResult value) {
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
  }
}
//(\d{1,4})年(\d{1,2})月(\d{1,2})
