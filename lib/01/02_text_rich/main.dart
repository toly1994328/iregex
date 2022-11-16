import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});

  final String src = '这是一段测试文字';
  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    String part1 = src.substring(0, 4);
    String part2 = src.substring(4, 6);
    String part3 = src.substring(6, 8);

    InlineSpan inlineSpan = TextSpan(children: [
      TextSpan(text: part1),
      TextSpan(text: part2, style: lightTextStyle),
      TextSpan(text: part3),
    ]);

    return Scaffold(
      body: Center(child: Text.rich(inlineSpan)),
    );
  }
}
