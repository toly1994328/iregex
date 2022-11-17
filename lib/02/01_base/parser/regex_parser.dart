import 'package:flutter/material.dart';

const kRenderColors = [Colors.red, Colors.green, Colors.blue];

class RegexParser{
  const RegexParser();

  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  InlineSpan formSpan(String src, String pattern) {
    List<TextSpan> span = [];
    RegExp regExp;
    try {
      regExp = RegExp(pattern);
    } catch (e) {
      return TextSpan(text: src);
    }
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