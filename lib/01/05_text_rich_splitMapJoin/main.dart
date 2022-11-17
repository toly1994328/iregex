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

const kRenderColors = [Colors.red, Colors.green, Colors.blue];

class _MyHomePageState extends State<MyHomePage> {
  String src = '中国陆地面积约960万平方千米，东部和南部大陆海岸线1.8万多千米，内海和边海的水域面积约470多万平方千米。海域分布有大小岛屿7600多个，其中台湾岛最大，面积35798平方千米 。中国同14国接壤，与8国海上相邻。省级行政区划为23个省、5个自治区、4个直辖市、2个特别行政区。';

  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    InlineSpan span = formSpan(src, r'\d');

    return Scaffold(
      body: Center(
          child: SizedBox(
            width: 350,
            child: Text.rich(
                span),
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  InlineSpan formSpan(String src, String pattern) {
    List<TextSpan> span = [];
    RegExp regExp = RegExp(pattern);
    int index = 0;
    src.splitMapJoin(regExp, onMatch: (Match match) {
      String value = match.group(0) ?? '';
      Color color = kRenderColors[index % kRenderColors.length];
      TextStyle style = lightTextStyle.copyWith(color: color);
      span.add(TextSpan(text: value, style: style));
      index++;
      return '';
    }, onNonMatch: (str) {
      span.add(TextSpan(text: str));
      return '';
    });
    return TextSpan(children: span);
  }
}
