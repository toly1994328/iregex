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

  String regex = '';
  String src = 'I have a dream that one day every valley shall be exalted, and every hill and mountain shall be made low, the rough places will be made plain, and the crooked places will be made straight; and the glory of the Lord shall be revealed and all flesh shall see it together.';

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
