import 'package:flutter/material.dart';
import 'package:regexp/09/play_regexp_v6/model/match_result.dart';

class MatchPanel extends StatefulWidget {
  final ValueNotifier<MatchResult> matchResult;

  const MatchPanel(this.matchResult, {Key? key}) : super(key: key);

  @override
  _MatchPanelState createState() => _MatchPanelState();
}

class _MatchPanelState extends State<MatchPanel> {
  List<String> data = [];
 final ScrollController _ctrl = ScrollController();

  @override
  void initState() {
    super.initState();
    data = List.generate(20, (index) => '${index}');
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
        Divider(),
        Expanded(
            child: ValueListenableBuilder(
          valueListenable: widget.matchResult,
          builder: _buildByMatchResult,
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
        Color color = colors[value.results[index].matchIndex%colors.length];

        if(info.end){
          return const Divider();
        }else{
          return Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                        width: 2,
                          color: color
                      )
                  )
              ),
              child: const Divider(color: Colors.transparent,));
        }
      },
      itemBuilder: (_, index) {
        int groupNum = value.results[index].groupNum;
        String name = groupNum == 0 ? "Match  $index" : "Group  $groupNum";
        Color color = colors[value.results[index].matchIndex%colors.length];
        return Container(
          padding: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                  width: 2,
                color: color
              )
            )
          ),
          child: Wrap(
            // direction: Axis.vertical,
            children: [
              Row(
                children: [
                  Text(name,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  Spacer(),
                  Text('位置:${value.results[index].startPos}-${value.results[index].endPos}',style: TextStyle(fontSize: 10,color: Colors.grey),),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("匹配结果: ${value.results[index].content}",maxLines: 4,overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12,color:  Colors.grey ),),
              ),
            ],
          ),
        );
      },
      itemCount: value.results.length,
    );
  }
}
//(\d{1,4})年(\d{1,2})月(\d{1,2})
