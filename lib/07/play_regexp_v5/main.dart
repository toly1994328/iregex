import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:regexp/app/iconfont/toly_icon.dart';

import 'components/single_chip_filter.dart';
import 'model/reg_test_item.dart';
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

class MatchResult {
  final bool error;
  final int resultCount;

  MatchResult({this.error = false, this.resultCount = 0});
}

class _MyHomePageState extends State<MyHomePage> {
  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  late InlineSpan inlineSpan;

  ValueNotifier<MatchResult> matchResult = ValueNotifier(MatchResult());
  final TextEditingController regTextCtrl = TextEditingController();
  late ValueNotifier<RegTestItem> regTestContentCtrl;

  @override
  void initState() {
    super.initState();
    regTestContentCtrl = ValueNotifier(RegTestItem.fromJson({
      "title": "中国地域",
      "subtitle": "测试数字",
      "recommend": ["\\d", "\\d+", "(\\d+\\.\\d+)|(\\d+)"],
      "content":
          "中国陆地面积约960万平方千米，东部和南部大陆海岸线1.8万多千米，内海和边海的水域面积约470多万平方千米。海域分布有大小岛屿7600多个，其中台湾岛最大，面积35798平方千米 。中国同14国接壤，与8国海上相邻。省级行政区划为23个省、5个自治区、4个直辖市、2个特别行政区。"
    }));
    _updateContent();
    _updateSpan();
    regTextCtrl.addListener(_updateSpan);
    regTestContentCtrl.addListener(_updateContent);
  }

  void _updateSpan() {
    inlineSpan = formSpan(regTestContentCtrl.value.content, regTextCtrl.text);
  }

  void _updateContent() {
    if (regTestContentCtrl.value.recommend.isNotEmpty) {
      regTextCtrl.text = regTestContentCtrl.value.recommend[0];
    }else{
      _updateSpan();
    }
  }

  @override
  void dispose() {
    regTextCtrl.dispose();
    regTestContentCtrl.dispose();
    matchResult.dispose(); //tag1
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: SwitchEndDrawer(
          contentTextCtrl: regTestContentCtrl,
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
                valueListenable: regTestContentCtrl, builder: _buildFilter),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 480,
                  child: ValueListenableBuilder<RegTestItem>(
                    valueListenable: regTestContentCtrl,
                    builder: (_, __, ___) {
                      return ValueListenableBuilder<TextEditingValue>(
                        valueListenable: regTextCtrl,
                        builder: (_, __, ___) {
                          return Text.rich(inlineSpan);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }

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
    return SizedBox(
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
        ));
  }

  List<Color> colors = [Colors.red, Colors.green, Colors.blue];
  final List<String> sList = ['\t','\v','\n','\r','\f'];

  InlineSpan formSpan(String src, String pattern) {
    if (pattern.isEmpty) {
      matchResult.value = MatchResult();
      return TextSpan(text: src);
    }
    List<TextSpan> span = [];
    late RegExp regExp;
    try {
      regExp = RegExp(pattern, multiLine: true);
    } catch (e) {
      matchResult.value = MatchResult(error: true);
      return TextSpan(text: src);
    }

    List<RegExpMatch> allMatches = regExp.allMatches(src).toList();
    matchResult.value = MatchResult(resultCount: allMatches.length);
    if(allMatches.isEmpty){
      return TextSpan(text: src);
    }

    int start = 0;
    int end = 0;
    for(int i=0;i<allMatches.length;i++){
      RegExpMatch? prevMatch;
      if(i>0){
        prevMatch = allMatches[i-1];
      }
      RegExpMatch match = allMatches[i];
      start = prevMatch?.end??0;
      end = match.start;
      String noMatchStr =match.input.substring(start,end);
      span.add(TextSpan(text: noMatchStr));

      start = match.start;
      end = match.end;
      String matchStr = match.input.substring(start,end);
      if(matchStr.isEmpty||sList.contains(matchStr)){
        span.add(TextSpan(
          text: ' ',
          style: lightTextStyle.copyWith(
              backgroundColor: colors[i % colors.length].withOpacity(0.5)),
        ));
      }


      span.add(TextSpan(
        text: matchStr.replaceAll(" ", '␣'),
        style: lightTextStyle.copyWith(
            color: colors[i % colors.length]),
      ));

      if(i==allMatches.length-1){
        String tail = match.input.substring(allMatches.last.end);
        span.add(TextSpan(text: tail));
      }
    }
    return TextSpan(children: span);
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
    if(reg==null){
      regTextCtrl.text = '';
    }else{
      regTextCtrl.text = reg;
    }
  }

  Widget _buildFilter(BuildContext context, RegTestItem value, Widget? child) {
    if(value.recommend.isEmpty){
      return const SizedBox();
    }
    return SingleChipFilter<String>(
      label: '推荐正则:',
      data: value.recommend,
      avatarBuilder: (_, index) =>
          CircleAvatar(child: Text((index + 1).toString())),
      labelBuilder: (_, index, selected) => Text('${value.recommend[index]}'),
      //     Icon(
      //   Icons.star,
      //   color: selected ? Colors.blue : Colors.grey,
      //   size: 18,
      // ),
      onSelected: _doSelectStart,
    );
  }
}
