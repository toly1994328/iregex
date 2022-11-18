import 'dart:io';

import 'package:flutter/material.dart';

import '../parser/regex_parser.dart';
import 'content_text_panel.dart';
import 'home_top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String src = '中国陆地面积约960万平方千米，东部和南部大陆海岸线1.8万多千米，内海和边海的水域面积约470多万平方千米。海域分布有大小岛屿7600多个，其中台湾岛最大，面积35798平方千米 。中国同14国接壤，与8国海上相邻。省级行政区划为23个省、5个自治区、4个直辖市、2个特别行政区。';
  String regex = '';
  String src = 'I have a dream';
  // String src = '我有一个梦想';
  final RegexParser parser = const RegexParser(
    multiLine: true
  );

  InlineSpan get span => parser.formSpan(src, regex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeTopBar(
            onRegexChange: _onRegexChange,
            onFileSelect: _onFileSelect,
          ),
          Expanded(
            child: ContentTextPanel(
              span: span,
            ),
          ),
        ],
      ),
    );
  }

  void _onFileSelect(File file) {
    src = file.readAsStringSync();
    setState(() {});
  }

  void _onRegexChange(String value) {
    regex = value;
    setState(() {});
  }
}
