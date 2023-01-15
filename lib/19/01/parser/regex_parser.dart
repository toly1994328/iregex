import 'package:flutter/material.dart';
import 'package:string_scanner/string_scanner.dart';

import '../highlight_style/highlight.dart';
import '../highlight_style/highlight_style.dart';
import '../language/dart_lang.dart';
import '../language/language.dart';
import '../models/highlight_match.dart';
import '../rules/line.dart';
import '../rules/match_rule.dart';

class RegexParser {

  final Language language = DartLanguage();
  final HighlightStyle highlightStyle = CustomHighlightStyle(
    highlight: Highlight.magula,
  );

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

  final TextStyle lineStyle = const TextStyle(
    fontSize: 12,
    color: Colors.grey,
    // fontWeight: FontWeight.bold,
  );

  List<InlineSpan> _handleHeightMatches(
    List<HighlightMatch> heightMatches,
    String string,
  ) {
    RegExp exp = RegExp(r'^',multiLine: true);
    List<int> slots = exp.allMatches(string).map((e) => e.start).toList();
    List<InlineSpan> span = [];
    int cursor = 0;

    int slotCursor = 0;


    insertSlotWithBoundary(int start, int end, TextStyle style,{bool showLine = true}) {
      if (slotCursor>=slots.length||slots[slotCursor] > end || !showLine) {
        // 说明当前段没有槽点，无需处理
        span.add(TextSpan(
          text: string.substring(start, end),
          style: style,
        ));
        return;
      }
      // 有槽点，分割插槽
      String matchStr = string.substring(start, slots[slotCursor]);
      span.add(TextSpan(
        text: matchStr,
        style: style,
      ));
      while (slots[slotCursor] < end) {
        int slotPosition = slots[slotCursor];
        slotCursor++;
        int currentEndPosition = 0;
        if (slotCursor == slots.length || slots[slotCursor] > end) {
          // 说明插槽结束
          // 说明下一槽点不再当前段
          currentEndPosition = end;
        } else {
          currentEndPosition = slots[slotCursor];
        }
        span.add(WidgetSpan(child: SizedBox(width: 60,child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text( '$slotCursor', textAlign: TextAlign.right, style: lineStyle),
        ),)));
        String matchStr2 = string.substring(slotPosition, currentEndPosition);
        span.add(TextSpan(
          text: matchStr2,
          style: style,
        ));
        if (slotCursor > slots.length - 1) break;
      }
    }

    for (int i = 0; i < heightMatches.length; i++) {
      // 插入节点
      HighlightMatch match = heightMatches[i];

      if (cursor != match.start) {
        insertSlotWithBoundary(cursor,match.start,highlightStyle.mapStyleByMatchRule(null));
      }
      insertSlotWithBoundary(match.start,match.end,highlightStyle.mapStyleByMatchRule(  match.rule,));

      cursor = match.end;
    }
    if (cursor != string.length - 1) {
      insertSlotWithBoundary(cursor,string.length,highlightStyle.mapStyleByMatchRule(null));

    }
    return span;
  }
}
