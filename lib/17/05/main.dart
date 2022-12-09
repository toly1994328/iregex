import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final RegexParser parser = const RegexParser();

  final String content = """# 标题一
## 标题二
### 标题三
可能说起 [Flutter 绘制](https://juejin.cn/book/6844733827265331214)大家第一反应就是用 `CustomPaint` 组件，自定义 `CustomPainter` 对象来画。Flutter 中所有可以看得到的组件，比 [Text](https://juejin.cn/post/6916297631366905864)、[Image](https://juejin.cn/post/6916297631366905864)、*Switch*、*Slider*等等，追其根源都是 `画出来` 的，但通过查看**源码**可以发现，Flutter 中大多数组件并不是用 `CustomPaint` 组件来画的，其实 `CustomPaint` 组件是对底层绘制的一层**封装**。这个[系列](https://juejin/post/6916297631366905864)便是对 Flutter 绘制的探索，通过`测试`、`调试`、及`源码分析`来给出一些在绘制时`被忽略`或`从未知晓`的东西，而有些要点如果被忽略，就很可能**出现问题**。
![flutter_unit](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4f678f584dad4938932610a19fc979a8~tplv-k3u1fbpfcp-watermark.image)
### 标题四
##### 标题五
###### 标题六
content。# 777
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 520,
          child: Text.rich(parser.formSpan(content)),
        ),
      ),
    );
  }
}
