import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:regexp/src/app/iconfont/toly_icon.dart';
import 'package:regexp/src/app/style/app_theme_data.dart';

import 'parser/regex_parser.dart';

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
      home:  HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RegexParser parser =  RegexParser();

  String content = '''
/** 
** create by 张风捷特烈 on 2022-12-10
** contact me by email 1981462002@qq.com
**/

const String _kCounty = 'China'; # 常量

/// 代码高亮测试案例
class Hello {
  final String name; //名称
  final String county; //国家
  final int age; //年龄
  final double height; //身高

  Hello({
    this.name = "张风捷特烈",
    this.age = 28,
    this.height = 1.80, 
    this.county = _kCounty
  });

  @override
  String toString() {
    int a = 0xff9999;
    int b = 1.0f;
    int c = 1.0e5;
    String prefix = r'\\d+'; 
    String label = """toly1994
    张风捷特烈
    """;
    return 'Hello{name: \$name}';
  }
}
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffefecf4),
      backgroundColor: parser.bgColor,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: GestureDetector(
              onTap: onSelect,
              child: const Icon(TolyIcon.icon_file, size: 22),
            ),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          child: SingleChildScrollView(child: Text.rich(parser.formSpan(content))),
        ),
      ),
    );
  }

  void onSelect() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String? path = result.files.single.path;
      if (path != null) {
        content = File(path).readAsStringSync();
        setState(() {

        });
      }
    }
  }
}
