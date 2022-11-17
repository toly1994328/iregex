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
  String src = '';
  String regex = '';

  final RegexParser parser = const RegexParser();

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
