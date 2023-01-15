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
        child: Text.rich(formSpan()),
      ),
    );
  }

  TextSpan formSpan() {
    StringScanner scanner = StringScanner("toly 1994,hello!");
    List<HeightMatch> heightMatches = [];
    while (!scanner.isDone) {
      if (scanner.scan(RegExp(r'\d+'))) {
        Match? match = scanner.lastMatch;
        if (match != null) {
          HeightMatch heightMatch = HeightMatch(HighlightType.type1, match.start, match.end);
          heightMatches.add(heightMatch);
        }
        continue;
      }
      if (scanner.scan(RegExp(r'o.'))) {
        Match? match = scanner.lastMatch;
        if (match != null) {
          HeightMatch heightMatch = HeightMatch(HighlightType.type2, match.start, match.end);
          heightMatches.add(heightMatch);
        }
        continue;
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
      String matchStr = string.substring(match.start, match.end);
      span.add(TextSpan(text: matchStr, style: match.style));
      cursor = match.end;
    }
    if (cursor != string.length-1) {
      span.add(TextSpan(text: string.substring(cursor)));
    }
    return span;
  }
}

enum HighlightType {
  type1,
  type2,
}

class HeightMatch {
  final HighlightType type;
  final int start;
  final int end;

  HeightMatch(this.type, this.start, this.end);

  TextStyle get style => kHeightMap[type]!;
}

const Map<HighlightType, TextStyle> kHeightMap = {
  HighlightType.type1: TextStyle(
    fontSize: 16,
    color: Colors.red,
    fontWeight: FontWeight.bold,
  ),
  HighlightType.type2: TextStyle(
    fontSize: 26,
    color: Colors.deepPurple,
    fontWeight: FontWeight.bold,
  ),
};


