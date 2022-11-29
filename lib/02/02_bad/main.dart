import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:regexp/src/app/iconfont/toly_icon.dart';

void main() {
  runApp(const MyApp());
  DesktopWindow.setWindowSize(const Size(600, 400));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'regexpo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

const kRenderColors = [Colors.red, Colors.green, Colors.blue];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String src = '';
  String regex = '';

  @override
  Widget build(BuildContext context) {
    InlineSpan span = formSpan(src, regex);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            color: const Color(0xffF2F2F2),
            child: Row(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                child: GestureDetector(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      String? path = result.files.single.path;
                      if (path != null) {
                        src = File(path).readAsStringSync();
                        setState(() {});
                      }
                    }
                  },
                  child: const Icon(TolyIcon.icon_file, size: 22),
                ),
              ),
              Expanded(
                  child: SizedBox(
                height: 28,
                child: TextField(
                  onChanged: (value) {
                    regex = value;
                    setState(() {});
                  },
                  style: const TextStyle(fontSize: 12),
                  maxLines: 1,
                  decoration: const InputDecoration(
                      filled: true,
                      hoverColor: Colors.transparent,
                      contentPadding: EdgeInsets.zero,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.edit, size: 18),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      hintText: "输入正则表达式...",
                      hintStyle: TextStyle(fontSize: 12)),
                ),
              )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(blurRadius: 1, color: Colors.blue)
                      ]),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage('assets/images/icon_head.webp'),
                  ),
                ),
              ),
            ]),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text.rich(span),
            ),
          ),
        ],
      ),
    );
  }

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
