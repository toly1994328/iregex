import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexp/src/app/style/app_theme_data.dart';
import 'package:regexp/src/blocs/blocs.dart';
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

  final TextStyle style1 = const TextStyle(
    fontSize: 16,
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );
  final TextStyle style2 = const TextStyle(
    fontSize: 26,
    color: Colors.deepPurple,
    fontWeight: FontWeight.bold,
  );

  TextSpan formSpan() {
    StringScanner scanner = StringScanner("toly 1994,hello!");
    List<InlineSpan> span = [];
    while (!scanner.isDone) {
      if (scanner.scan(RegExp(r'\d+'))) {
        String? matchStr = scanner.lastMatch?.group(0);
        span.add(TextSpan(text: matchStr, style: style1));
        continue;
      }
      if (scanner.scan(RegExp(r'o.'))) {
        String? matchStr = scanner.lastMatch?.group(0);
        span.add(TextSpan(text: matchStr, style: style2));
        continue;
      }
      span.add(TextSpan(text: scanner.string[scanner.position]));
      scanner.position++;
    }
    return TextSpan(
        children: span
    );
  }

}
