import 'package:flutter/material.dart';

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
  String src =
      '中国陆地面积约960万平方千米，东部和南部大陆海岸线1.8万多千米，内海和边海的水域面积约470多万平方千米。海域分布有大小岛屿7600多个，其中台湾岛最大，面积35798平方千米 。中国同14国接壤，与8国海上相邻。省级行政区划为23个省、5个自治区、4个直辖市、2个特别行政区。';

  // String src =
  //     '中国是世界上动物资源最为丰富的国家之一。据统计，中国陆栖脊椎动物约有2070种，占世界陆栖脊椎动物的9.8%。其中鸟类1170多种、兽类400多种、两栖类184种，分别占世界同类动物的13.5%、11.3%和7.3%。';


  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  late InlineSpan inlineSpan;

  ValueNotifier<MatchResult> matchResult = ValueNotifier(MatchResult());
  final TextEditingController regTextCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateSpan();
    regTextCtrl.addListener(_updateSpan);
  }

  void _updateSpan() {
    inlineSpan = formSpan(src, regTextCtrl.text);
  }

  @override
  void dispose() {
    regTextCtrl.dispose();
    matchResult.dispose();//tag1
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: buildSearchBar(context),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: buildResultInfo(),
            ),
          ],
        ),
        body: Center(
            child: SizedBox(
          width: 350,
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: regTextCtrl,
            builder: (_, __, ___) {
              return Text.rich(inlineSpan);
            },
          ),
        )));
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

    InlineSpan formSpan(String src, String pattern) {
    if (pattern.isEmpty) {
      matchResult.value = MatchResult();
      return TextSpan(text: src);
    }
    List<TextSpan> span = [];
    late RegExp regExp;
    try {
      regExp = RegExp(pattern);
    } catch (e) {
      matchResult.value = MatchResult(error: true);
      return TextSpan(text: src);
    }
    List<String> parts = src.split(regExp);
    List<RegExpMatch> allMatches = regExp.allMatches(src).toList();
    matchResult.value = MatchResult(resultCount: allMatches.length);
    if (parts.length > 1) {
      for (int i = 0; i < parts.length; i++) {
        span.add(TextSpan(text: parts[i]));
        if (i != parts.length - 1) {
          span.add(TextSpan(
            text: allMatches[i].group(0),
            style: lightTextStyle.copyWith(color: colors[i % colors.length]),
          ));
        }
      }
    } else {
      span.add(TextSpan(text: src));
    }
    return TextSpan(children: span);
  }
}
