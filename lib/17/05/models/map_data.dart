import 'package:flutter/material.dart';

enum HighlightType {
  lineBloc,
  bold,
  italic,
  boldItalic,
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  link,
  image,
}

Map<HighlightType, Pattern> ruleMap = {
  HighlightType.lineBloc: RegExp(r"`(?<result>.*?)`"),
  HighlightType.boldItalic: RegExp(r"(\*{3})(?<result>.*?)(\*{3})"),
  HighlightType.bold: RegExp(r"(\*{2})(?<result>.*?)(\*{2})"),
  HighlightType.italic: RegExp(r"\*(?<result>.*?)\*"),
  HighlightType.h1: RegExp(r"^# (?<result>.*)", multiLine: true),
  HighlightType.h2: RegExp(r"^## (?<result>.*)", multiLine: true),
  HighlightType.h3: RegExp(r"^### (?<result>.*)", multiLine: true),
  HighlightType.h4: RegExp(r"^#### (?<result>.*)", multiLine: true),
  HighlightType.h5: RegExp(r"^##### (?<result>.*)", multiLine: true),
  HighlightType.h6: RegExp(r"^###### (?<result>.*)", multiLine: true),
  HighlightType.image: RegExp(r"!\[(?<result>.*?)\](\((?<url>.*?)\))"),
  HighlightType.link: RegExp(r"\[(?<result>.*?)\]\((?<url>.*?)\)"),
};


const Map<HighlightType, TextStyle> kHighlightMap = {
  HighlightType.lineBloc: TextStyle(color: Colors.purple, fontSize: 14),
  HighlightType.bold: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  HighlightType.italic: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
  HighlightType.boldItalic: TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
  HighlightType.h1:
  TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
  HighlightType.h2:
  TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
  HighlightType.h3:
  TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  HighlightType.h4:
  TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
  HighlightType.h5:
  TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
  HighlightType.h6:
  TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
  HighlightType.link: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, decorationColor: Colors.blue),
  HighlightType.image: TextStyle(color: Colors.grey),
};