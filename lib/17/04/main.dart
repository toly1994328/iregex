import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:regexp/src/app/style/app_theme_data.dart';
import 'package:string_scanner/string_scanner.dart';

void main() {
  runApp(const MyApp());
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    DesktopWindow.setWindowSize(const Size(900, 600));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'regexpo',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.light,
      darkTheme: AppThemeData.dark,
      home: const HomePage(),
    );
  }
}




class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(width: 520, child: Text.rich(formSpan())),
      ),
    );
  }

  TextSpan formSpan() {
    StringScanner scanner = StringScanner("""
    可能说起 ***Flutter*** 绘制大家第一反应就是用 `CustomPaint` 组件，自定义 `CustomPainter` 对象来画。***Flutter*** 中所有可以看得到的组件，比 *Text*、*Image*、*Switch*、*Slider*等等，追其根源都是 `画出来` 的，但通过查看**源码**可以发现，***Flutter*** 中大多数组件并不是用 `CustomPaint` 组件来画的，其实 `CustomPaint` 组件是对底层绘制的一层**封装**。这个系列便是对 ***Flutter*** 绘制的探索，通过`测试`、`调试`、及`源码分析`来给出一些在绘制时`被忽略`或`从未知晓`的东西，而有些要点如果被忽略，就很可能**出现问题**。
    """);

    List<Pattern> rules = ruleMap.values.toList();
    List<HighlightType> types = ruleMap.keys.toList();

    List<HeightMatch> heightMatches = [];
    while (!scanner.isDone) {
      next:
      for (int i = 0; i < rules.length; i++) {
        if (scanner.scan(rules[i])) {
          Match? match = scanner.lastMatch;
          if (match != null&& match is RegExpMatch) {
            String value = match.namedGroup('result') ?? '';
            HeightMatch heightMatch = HeightMatch(types[i], value, match.start, match.end);
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
    List<HeightMatch> heightMatches,
    String string,
  ) {
    List<InlineSpan> span = [];
    int cursor = 0;
    for (int i = 0; i < heightMatches.length; i++) {
      HeightMatch match = heightMatches[i];
      if (cursor != match.start) {
        span.add(TextSpan(text: string.substring(cursor, match.start)));
      }
      span.add(TextSpan(text: match.value, style: match.style));
      cursor = match.end;
    }
    if (cursor != string.length - 1) {
      span.add(TextSpan(text: string.substring(cursor)));
    }
    return span;
  }
}

enum HighlightType {
  lineBloc,
  bold,
  italic,
  boldItalic,
}

Map<HighlightType,Pattern> ruleMap = {
  HighlightType.lineBloc: RegExp(r"`(?<result>.*?)`"),
  HighlightType.boldItalic: RegExp(r"(\*{3})(?<result>.*?)(\*{3})"),
  HighlightType.bold: RegExp(r"(\*{2})(?<result>.*?)(\*{2})"),
  HighlightType.italic: RegExp(r"\*(?<result>.*?)\*"),
};

// class MatchRule {
//   final HighlightType type;
//   final Pattern rule;
//
//   MatchRule(this.type, this.rule);
// }

class HeightMatch {
  final HighlightType type;
  final String value;
  final int start;
  final int end;

  HeightMatch(this.type, this.value, this.start, this.end);

  TextStyle get style => kHighlightMap[type]!;
}

const Map<HighlightType, TextStyle> kHighlightMap = {
  HighlightType.lineBloc: TextStyle(color: Colors.purple, fontSize: 14),
  HighlightType.bold: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  HighlightType.italic: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
  HighlightType.boldItalic: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
};
