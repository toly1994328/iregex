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
  String src = '这是一段测试文字';
  final TextStyle lightTextStyle = const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {

    InlineSpan inlineSpan = TextSpan(children: [
      TextSpan(text: src.substring(0, 4),),
      TextSpan(text: src.substring(4, 6), style: lightTextStyle),
      TextSpan(text: src.substring(6)),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text.rich(inlineSpan),
      ),
      body: Center(
          child: Text.rich(inlineSpan)), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
