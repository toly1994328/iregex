import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    DesktopWindow.setWindowSize(const Size(600, 400));
    DesktopWindow.setMinWindowSize(const Size(200, 200));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, cts) {
        double width = cts.maxWidth;
        return Row(
          children: [
            if (width > 350) const Side(),
            const Expanded(child: GridContent())
          ],
        );
      },
    );
  }
}

class GridContent extends StatelessWidget {
  const GridContent({super.key});

  List<int> get data => List.generate(60, (index) => index);

  @override
  Widget build(BuildContext context) {
    SliverGridDelegate gridDelegate =
        const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 360,
      mainAxisSpacing: 8,
      mainAxisExtent: 80,
      crossAxisSpacing: 8,
    );

    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: data.length,
        gridDelegate: gridDelegate,
        itemBuilder: (_, index) {
          return GridItem(
            index: index,
          );
        });
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: 40,
      width: 40,
      decoration:
          const BoxDecoration(color: Color(0xff9B9B9B), shape: BoxShape.circle),
    );
  }
}

class GridItem extends StatelessWidget {
  final int index;

  const GridItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xffEBEBEB),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
            child: Row(
              children: [
                const Logo(),
                Container(
                  width: 80,
                  height: 20,
                  color: Colors.black54,
                ),
                const Spacer(),
                const Icon(Icons.star)
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (ctx, cts) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.black12,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Side extends StatelessWidget {
  const Side({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      color: const Color(0xffE7E3E6),
    );
  }
}

const _kColors = [Color(0xffCBCBCB), Color(0xffEBEBEB)];
