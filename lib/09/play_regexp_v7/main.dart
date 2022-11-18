import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:regexp/09/play_regexp_v7/model/regexp_config.dart';
import 'package:regexp/09/play_regexp_v7/views/tool_panel.dart';
import 'package:regexp/app/iconfont/toly_icon.dart';

import 'components/single_chip_filter.dart';
import 'model/match_result.dart';
import 'model/reg_test_item.dart';
import 'views/match_panel.dart';
import 'views/setting_drawer.dart';
import 'views/switch_end_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  late InlineSpan inlineSpan;

  ValueNotifier<MatchResult> matchResult = ValueNotifier(MatchResult());
  ValueNotifier<MatchInfo?> selectMatchInfo = ValueNotifier(null);
  ValueNotifier<RegExpConfig> regExpConfig = ValueNotifier(RegExpConfig());
  final TextEditingController regTextCtrl = TextEditingController();
  late ValueNotifier<RegTestItem> selectSideItem;

  @override
  void initState() {
    super.initState();
    selectSideItem = ValueNotifier(RegTestItem.fromJson({
      "title": "中国地域",
      "subtitle": "测试数字",
      "recommend": ["\\d", "\\d+", "(\\d+\\.\\d+)|(\\d+)"],
      "content":
          "中国陆地面积约960万平方千米，东部和南部大陆海岸线1.8万多千米，内海和边海的水域面积约470多万平方千米。海域分布有大小岛屿7600多个，其中台湾岛最大，面积35798平方千米 。中国同14国接壤，与8国海上相邻。省级行政区划为23个省、5个自治区、4个直辖市、2个特别行政区。"
    }));
    _updateSelectSideItem();
    _updateSpan();
    regTextCtrl.addListener(_updateRegInput);
    selectSideItem.addListener(_updateSelectSideItem);
    selectMatchInfo.addListener(_updateSelectMatch);
    regExpConfig.addListener(_updateSpan);
  }

  void _updateRegInput() {
    _updateSpan();
  }

  void _updateSelectMatch() {
    _updateSpan();
  }

  void _updateSpan({String debugLabel = ''}) {
    inlineSpan = formSpan(selectSideItem.value.content, regTextCtrl.text);
  }

  void _updateSelectSideItem() {
    if (selectSideItem.value.recommend.isNotEmpty) {
      String recommend = selectSideItem.value.recommend[0];
      if (recommend != regTextCtrl.text) {
        regTextCtrl.text = recommend;
        return;
      }
    }
    _updateSpan();
  }

  @override
  void dispose() {
    regTextCtrl.dispose();
    selectSideItem.dispose();
    matchResult.dispose(); //tag1
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SettingDrawer(regExpConfig: regExpConfig),
        endDrawer: SwitchEndDrawer(
          contentTextCtrl: selectSideItem,
        ),
        floatingActionButton: Builder(
          builder: _buildFAB,
        ),
        appBar: AppBar(
          title: buildSearchBar(context),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: buildResultInfo(),
            ),
          ],
        ),
        body: Column(
          children: [
            ValueListenableBuilder<RegTestItem>(
              valueListenable: selectSideItem,
              builder: _buildFilter,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 8, bottom: 8, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: buildMatchPanel(),
                    ),
                    Expanded(
                      flex: 6,
                      child: buildTextPanel(),
                    ),
                    // Expanded(
                    //   flex: 3,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color: const Color(0xffFDFDFD),
                    //         boxShadow: [
                    //           //inset 0 1px 2px #ddd,0 0 5px rgba(69,122,187,.4)
                    //           BoxShadow(
                    //               offset: Offset(0, 1),
                    //               color: const Color(0xffdddddd),
                    //               blurRadius: 2)
                    //         ],
                    //         borderRadius: BorderRadius.circular(6)),
                    //     padding: EdgeInsets.all(8),
                    //     margin: EdgeInsets.only(left: 8, right: 8, bottom: 55),
                    //     child: ValueListenableBuilder(
                    //       valueListenable: regTextCtrl,
                    //       builder: (_, __, ___) => ToolPanel(
                    //         matchResult,
                    //         onClickItem: (e) {
                    //           selectMatchInfo.value = e;
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildTextPanel() => Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: ValueListenableBuilder<MatchResult>(
                    valueListenable: matchResult,
                    builder: (_, ___, __) => Text.rich(inlineSpan)),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: ValueListenableBuilder(
                valueListenable: regExpConfig,
                builder: _buildByRegExpConfig,
              ))
        ],
      );

  Widget buildMatchPanel() => Container(
        decoration: BoxDecoration(
            color: const Color(0xffFDFDFD),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 1),
                color: Color(0xffdddddd),
                blurRadius: 2,
              )
            ],
            borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.all(8),
        child: ValueListenableBuilder(
          valueListenable: regTextCtrl,
          builder: (_, __, ___) => MatchPanel(
            matchResult,
            onClickItem: (e) {
              selectMatchInfo.value = e;
            },
          ),
        ),
      );

  final Widget errorStateWidget = const Text(
    '规则异常',
    style: TextStyle(fontSize: 12, color: Colors.red),
  );
  final Widget commonStateWidget = const Text(
    '规则正常',
    style: TextStyle(fontSize: 12, color: Colors.white),
  );

  Widget buildResultInfo() => ValueListenableBuilder(
        valueListenable: matchResult,
        builder: (_, MatchResult result, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            result.error ? errorStateWidget : commonStateWidget,
            Text(
              '匹配数: ${result.resultCount}',
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      );

  Widget buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
              height: 35,
              child: TextField(
                controller: regTextCtrl,
                maxLines: 1,
                decoration: const InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.only(top: 5),
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.edit, size: 20),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    hintText: "输入正则表达式...",
                    hintStyle: TextStyle(fontSize: 14)),
              )),
        ),
      ],
    );
  }

  List<Color> colors = [Colors.red, Colors.green, Colors.blue];
  final List<String> sList = ['\t', '\v', '\n', '\r', '\f'];

  InlineSpan formSpan(String src, String pattern) {
    if (pattern.isEmpty) {
      matchResult.value = MatchResult();
      return TextSpan(text: src);
    }
    List<TextSpan> span = [];
    late RegExp regExp;
    try {
      regExp = RegExp(
        pattern,
        multiLine: regExpConfig.value.multiLine,
        dotAll: regExpConfig.value.dotAll,
        unicode: regExpConfig.value.unicode,
        caseSensitive: regExpConfig.value.caseSensitive,
      );
    } catch (e) {
      matchResult.value = MatchResult(error: true);
      return TextSpan(text: src);
    }

    List<RegExpMatch> allMatches = regExp.allMatches(src).toList();

    if (allMatches.isEmpty) {
      matchResult.value = MatchResult();
      return TextSpan(text: src);
    }

    int start = 0;
    int end = 0;
    List<MatchInfo> matchInfos = [];

    for (int i = 0; i < allMatches.length; i++) {
      RegExpMatch match = allMatches[i];
      RegExpMatch? prevMatch;
      if (i > 0) {
        prevMatch = allMatches[i - 1];
      }
      start = prevMatch?.end ?? 0;
      end = match.start;
      String noMatchStr = match.input.substring(start, end);
      span.add(TextSpan(text: noMatchStr));

      start = match.start;
      end = match.end;
      String matchStr = match.input.substring(start, end);
      if (matchStr.isEmpty || sList.contains(matchStr)) {
        span.add(TextSpan(
          text: ' ',
          style: lightTextStyle.copyWith(
              backgroundColor: colors[i % colors.length].withOpacity(0.5)),
        ));
      }
      int? selectedMatch = selectMatchInfo.value?.matchIndex;

      late TextStyle textStyle;
      TextStyle lightBgStyle = lightTextStyle.copyWith(
          color: colors[i % colors.length], backgroundColor: Colors.cyanAccent);

      TextStyle colorStyle =
          lightTextStyle.copyWith(color: colors[i % colors.length]);

      if (selectMatchInfo.value != null) {
        //选择的不是组
        if (!selectMatchInfo.value!.isGroup) {
          if (i == selectedMatch) {
            textStyle = lightBgStyle;
          } else {
            textStyle = colorStyle;
          }
          span.add(TextSpan(
            text: matchStr.replaceAll(" ", '␣'),
            style: textStyle,
          ));
        } else {
          // 匹配的是组
          String groupContent = selectMatchInfo.value!.content ?? '';
          List<String> leftStr = matchStr.split(groupContent);
          if (leftStr.length == 2 && selectedMatch == i) {
            span.add(TextSpan(
              text: leftStr[0].replaceAll(" ", '␣'),
              style: colorStyle,
            ));

            span.add(TextSpan(
              text: groupContent.replaceAll(" ", '␣'),
              style: lightBgStyle,
            ));

            span.add(TextSpan(
              text: leftStr[1].replaceAll(" ", '␣'),
              style: colorStyle,
            ));
          } else {
            span.add(TextSpan(
              text: matchStr.replaceAll(" ", '␣'),
              style: colorStyle,
            ));
          }
        }
      } else {
        span.add(TextSpan(
          text: matchStr.replaceAll(" ", '␣'),
          style: colorStyle,
        ));
      }

      if (i == allMatches.length - 1) {
        String tail = match.input.substring(allMatches.last.end);
        span.add(TextSpan(text: tail));
      }
      matchInfos.addAll(collectMatchInfo(match, i));
    }

    matchResult.value = MatchResult(results: matchInfos);
    return TextSpan(children: span);
  }

  List<MatchInfo> collectMatchInfo(RegExpMatch match, int index) {
    List<MatchInfo> result = [];
    String fullContent = match.group(0) ?? '';
    result.add(MatchInfo(
        content: fullContent,
        groupNum: 0,
        startPos: match.start,
        endPos: match.end,
        matchIndex: index,
        end: match.groupCount == 0));

    for (int j = 1; j <= match.groupCount; j++) {
      String? content = match.group(j);
      if (content != null) {
        int start = fullContent.indexOf(content);
        result.add(MatchInfo(
            content: content,
            groupNum: j,
            startPos: match.start + start,
            endPos: match.start + content.length,
            matchIndex: index,
            end: j == match.groupCount));
      } else {
        result.add(MatchInfo(
            content: content,
            groupNum: j,
            startPos: -1,
            endPos: -1,
            matchIndex: index,
            end: j == match.groupCount));
      }
    }
    return result;
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
        mini: true,
        child: Icon(
          TolyIcon.icon_text_switch,
          size: 20,
        ),
        onPressed: () {
          Scaffold.of(context).openEndDrawer();
        });
  }

  void _doSelectStart(dynamic reg) {
    if (reg == null) {
      regTextCtrl.text = '';
    } else {
      regTextCtrl.text = reg;
    }
  }

  Widget _buildFilter(BuildContext context, RegTestItem value, Widget? child) {
    if (value.recommend.isEmpty) {
      return const SizedBox();
    }
    return SingleChipFilter<String>(
      label: '推荐正则:',
      data: value.recommend,
      avatarBuilder: (_, index) =>
          CircleAvatar(child: Text((index + 1).toString())),
      labelBuilder: (_, index, selected) => Text('${value.recommend[index]}'),
      onSelected: _doSelectStart,
    );
  }

  final List<String> configInfo = [
    'multiLine',
    'caseSensitive',
    'dotAll',
    'unicode',
  ];

  Widget _buildByRegExpConfig(
      BuildContext context, RegExpConfig value, Widget? child) {
    Color color = Theme.of(context).primaryColor;
    return Wrap(
      spacing: 4,
      children: configInfo.asMap().keys.map((int index) {
        bool active = false;
        if (index == 0) {
          active = value.multiLine;
        }
        if (index == 1) {
          active = value.caseSensitive;
        }
        if (index == 2) {
          active = value.dotAll;
        }
        if (index == 3) {
          active = value.unicode;
        }
        TextStyle style =
            TextStyle(fontSize: 12, color: Colors.grey.withOpacity(0.8));
        TextStyle activeStyle =
            TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color);
        return GestureDetector(
          onTap: () {
            if (index == 0) {
              regExpConfig.value = value.copyWith(multiLine: !value.multiLine);
            }
            if (index == 1) {
              regExpConfig.value =
                  value.copyWith(caseSensitive: !value.caseSensitive);
            }
            if (index == 2) {
              regExpConfig.value = value.copyWith(dotAll: !value.dotAll);
            }
            if (index == 3) {
              active = value.unicode;
              regExpConfig.value = value.copyWith(unicode: !value.unicode);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(
              configInfo[index],
              style: active ? activeStyle : style,
            ),
          ),
        );
      }).toList(),
    );
  }
}
