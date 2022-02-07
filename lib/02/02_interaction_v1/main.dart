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


class _MyHomePageState extends State<MyHomePage> {
  String src =
      '中国陆地面积约960万平方千米，东部和南部大陆海岸线1.8万多千米，内海和边海的水域面积约470多万平方千米。海域分布有大小岛屿7600多个，其中台湾岛最大，面积35798平方千米 。中国同14国接壤，与8国海上相邻。省级行政区划为23个省、5个自治区、4个直辖市、2个特别行政区。';
  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  late InlineSpan inlineSpan;

  final TextEditingController regTextCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateSpan();
    regTextCtrl.addListener(_updateSpan);
  }

  @override
  void dispose() {
    regTextCtrl.dispose();
    super.dispose();
  }

  void _updateSpan(){
    inlineSpan = formSpan(src, regTextCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: buildSearchBar(context),
        ),
        body: Center(
            child: SizedBox(
          width: 350,
          child:
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: regTextCtrl,
            builder: (_, __, ___) {
              return Text.rich(inlineSpan);
            },
          ),
        )));
  }

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
      return TextSpan(text: src);
    }
    List<TextSpan> span = [];
     RegExp regExp = RegExp(pattern);

    List<String> parts = src.split(regExp);
    List<RegExpMatch> allMatches = regExp.allMatches(src).toList();
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
