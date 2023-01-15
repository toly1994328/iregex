import 'package:flutter/material.dart';

import '../rules/match_rule.dart';

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


// const Map<Type, TextStyle> kHighlightMap = {
//   CommentMixin: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
//   StringMixin: TextStyle(color: Color(0xFF43A047), fontSize: 14),
// };