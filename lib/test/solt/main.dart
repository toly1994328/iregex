import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:regexp/src/app/style/app_theme_data.dart';

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

  final TextStyle style0 = const TextStyle(
    fontSize: 28,
    color: Colors.black,
  );
  final TextStyle style1 = const TextStyle(
    fontSize: 28,
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );
  final TextStyle style2 = const TextStyle(
    fontSize: 28,
    color: Colors.purple,
    fontWeight: FontWeight.bold,
  );

  TextSpan formSpan() {
    List<List<int>> matches = [[1, 2], [5, 8], [14, 15]];
    List<int> slots = [0, 2, 6, 8, 11, 13];
    String src = "toly 1994,hello!";
    List<InlineSpan> span = [];
    int cursor = 0;
    int slotCursor = 0;

    insertSlotWithBoundary(int start, int end, TextStyle style) {
      if (slotCursor>=slots.length||slots[slotCursor] > end) {
        // 说明当前段没有槽点，无需处理
        span.add(TextSpan(
          text: src.substring(start, end),
          style: style,
        ));
        return;
      }
      // 有槽点，分割插槽
      String matchStr = src.substring(start, slots[slotCursor]);
      span.add(TextSpan(text: matchStr, style: style));
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
        span.add(const WidgetSpan(child: FlutterLogo()));
        String matchStr2 = src.substring(slotPosition, currentEndPosition);
        span.add(TextSpan(
          text: matchStr2,
          style: style,
        ));
        if (slotCursor >= slots.length) break;
      }
    }

    for (int i = 0; i < matches.length; i++) {
      List<int> match = matches[i];
      insertSlotWithBoundary(cursor, match[0], style0);
      insertSlotWithBoundary(match[0], match[1] + 1, style1);
      cursor = match[1] + 1;
    }
    if (cursor != src.length - 1) {
      insertSlotWithBoundary(cursor,src.length, style0);
    }
    return TextSpan(children: span);
  }
}
