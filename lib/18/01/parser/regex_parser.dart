import 'package:flutter/material.dart';
import 'package:string_scanner/string_scanner.dart';

import '../highlight_style/dark_highlight_style.dart';
import '../highlight_style/highlight_style.dart';
import '../language/dart_lang.dart';
import '../language/language.dart';
import '../models/highlight_match.dart';
import '../rules/match_rule.dart';

class RegexParser {
  final Language language = DartLanguage();
  final HighlightStyle highlightStyle = const DarkHighlightStyle();

  RegexParser();

  Color get bgColor => highlightStyle.backgroundColor;

  TextSpan formSpan(String content) {
    StringScanner scanner = StringScanner(content);
    List<HighlightMatch> heightMatches = [];

    List<MatchRule> rules = language.rules;
    while (!scanner.isDone) {
      next:
      for (int i = 0; i < rules.length; i++) {
        if (scanner.scan(rules[i].pattern)) {
          Match? match = scanner.lastMatch;
          if (match != null) {
            String value = match.group(0) ?? '';
            HighlightMatch heightMatch = HighlightMatch(rules[i], value, match.start, match.end);
            heightMatches.add(heightMatch);
          }
          // 何等优雅!
          break next;
        }
      }
      scanner.position++;
    }
    List<InlineSpan> span = _handleHeightMatches(heightMatches, scanner.string);
    return TextSpan(children: span);
  }

  List<InlineSpan> _handleHeightMatches(
    List<HighlightMatch> heightMatches,
    String string,
  ) {
    List<InlineSpan> span = [];
    int cursor = 0;
    for (int i = 0; i < heightMatches.length; i++) {
      HighlightMatch match = heightMatches[i];
      if (cursor != match.start) {
        span.add(TextSpan(text: string.substring(cursor, match.start) ,style: highlightStyle.mapStyleByMatchRule(null)));
      }
      span.add(TextSpan(
          text: match.value,
          style: highlightStyle.mapStyleByMatchRule(
            match.rule,
          )));
      cursor = match.end;
    }
    if (cursor != string.length - 1) {
      span.add(TextSpan(text: string.substring(cursor),
          style: highlightStyle.mapStyleByMatchRule(null)));
    }
    return span;
  }
}
