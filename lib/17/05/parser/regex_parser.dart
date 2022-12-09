import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:string_scanner/string_scanner.dart';

import '../models/highlight_match.dart';
import '../models/map_data.dart';
import '../views/mark_down_image.dart';

class RegexParser {
  const RegexParser();

  TextSpan formSpan(String content) {
    StringScanner scanner = StringScanner(content);

    List<Pattern> rules = ruleMap.values.toList();
    List<HighlightType> types = ruleMap.keys.toList();

    List<HighlightMatch> heightMatches = [];
    while (!scanner.isDone) {
      next:
      for (int i = 0; i < rules.length; i++) {
        if (scanner.scan(rules[i])) {
          Match? match = scanner.lastMatch;
          if (match != null && match is RegExpMatch) {
            String value = match.namedGroup('result') ?? '';
            if (types[i] == HighlightType.link) {
              String url = match.namedGroup('url') ?? '';
              HighlightMatch heightMatch = LinkMatch(
                  url: url, start: match.start, end: match.end, value: value);
              heightMatches.add(heightMatch);
            } else if (types[i] == HighlightType.image) {
              String url = match.namedGroup('url') ?? '';
              HighlightMatch heightMatch = ImageMatch(
                  url: url, start: match.start, end: match.end, value: value);
              heightMatches.add(heightMatch);
            } else {
              HighlightMatch heightMatch =
                  HighlightMatch(types[i], value, match.start, match.end);
              heightMatches.add(heightMatch);
            }
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
        span.add(TextSpan(text: string.substring(cursor, match.start)));
      } else if (match is LinkMatch) {
        span.add(TextSpan(
          text: match.value,
          style: match.style,
          recognizer: TapGestureRecognizer()
            ..onTap = () => print("==to==${match.url}========"),
        ));
      }
      if (match is ImageMatch) {
        span.add(WidgetSpan(
            child: MarkdownImageWidget(
          match: match,
        )));
      } else {
        span.add(TextSpan(text: match.value, style: match.style));
      }
      cursor = match.end;
    }
    if (cursor != string.length - 1) {
      span.add(TextSpan(text: string.substring(cursor)));
    }
    return span;
  }
}
