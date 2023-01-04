import 'package:flutter/material.dart';

const kRenderColors = [Colors.red, Colors.green, Colors.blue];

class RegexParser {
  final bool multiLine;
  final bool caseSensitive;
  final bool unicode;
  final bool dotAll;

  const RegexParser({
    this.multiLine = false,
    this.caseSensitive = true,
    this.unicode = false,
    this.dotAll = false,
  });

  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  final Map<String, String> sListMap = const {
    '\t': 't',
    '\v': 'v',
    '\n': 'n',
    '\r': 'r',
    '\f': 'f',
  };

  InlineSpan formSpan(String src, String pattern) {
    if (pattern.isEmpty || src.isEmpty) {
      return TextSpan(text: src);
    }
    List<InlineSpan> span = [];
    RegExp regExp;
    try {
      regExp = RegExp(pattern,
          multiLine: multiLine,
          dotAll: dotAll,
          unicode: unicode,
          caseSensitive: caseSensitive);
    } catch (e) {
      return TextSpan(text: src);
    }
    int index = 0;
    src.splitMapJoin(regExp, onMatch: (Match match) {
      String value = match.group(0) ?? '';
      Color color = kRenderColors[index % kRenderColors.length];
      TextStyle style = lightTextStyle.copyWith(color: color);
      if (value.isEmpty) {
        TextStyle emptyStyle =
            style.copyWith(backgroundColor: color.withOpacity(0.6));
        span.add(TextSpan(text: '_', style: emptyStyle));
        // span.add(WidgetSpan(
        //     alignment: PlaceholderAlignment.middle,
        //     child: FlutterLogo(size: 12,)));
      } else if (sListMap.keys.contains(value)) {
        TextStyle emptyStyle = style.copyWith(
          color: Colors.white,
          backgroundColor: color.withOpacity(0.6),
        );
        span.add(TextSpan(
          text: sListMap[value]! + value,
          style: emptyStyle,
        ));
      } else if (value.contains(" ")) {
        span.add(TextSpan(text: value.replaceAll(" ", '␣'), style: style));
      } else {
        span.add(TextSpan(text: value, style: style));
      }
      index++;
      return '';
    }, onNonMatch: (str) {
      span.add(TextSpan(text: str));
      return '';
    });
    return TextSpan(children: span);
  }
}
