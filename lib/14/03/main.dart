import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    DesktopWindow.setWindowSize(const Size(600, 400));
    // DesktopWindow.setMinWindowSize(const Size(600, 400));
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return HomePage();
    return LayoutBuilder(
      builder: (ctx, cts) {
        print("=======${cts}============");
        // if(cts.maxWidth<400){
        //   return SmallWidthLayout();
        // }
        // if(cts.maxWidth>650){
        //   return LargeWithLayout();
        // }
        return GridContent();
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Side(),
        Expanded(child:  Content(
          index: 0,
        )),
        Expanded(child:  Content(
          index: 1,
        )),
      ],
    );
  }
}

class GridContent extends StatelessWidget {
  const GridContent({super.key});

  List<int> get data => List.generate(60, (index) => index);

  @override
  Widget build(BuildContext context) {
    SliverGridDelegateWithMaxCrossAxisExtent gridDelegate =
    SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 360,
        childAspectRatio: 16 / 5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8);

    // SliverGridDelegate  gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    //   crossAxisCount: 2,
    //   childAspectRatio:420/360,
    //     mainAxisSpacing: 8,
    //     crossAxisSpacing: 8
    // );

    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: data.length,
        gridDelegate: gridDelegate,
        itemBuilder: (_, index) {
          return Container(
            height: 56,
            color: _kColors[index % 2],
          );
        });
  }
}

class SmallWidthLayout extends StatelessWidget {
  const SmallWidthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(child: TopBox()),
          SizedBox(
            height: 8,
          ),
          Expanded(
              child: Content(
                index: 0,
              )),
          SizedBox(
            height: 8,
          ),
          Expanded(
              child: Content(
                index: 0,
              )),
          SizedBox(
            height: 8,
          ),
          Expanded(
              flex: 3,
              child: Content(
                index: 1,
              )),
        ],
      ),
    );
  }
}

class MiddleWidthLayout extends StatelessWidget {
  const MiddleWidthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Logo(),
              SizedBox(
                width: 8,
              ),
              Expanded(child: TopBox()),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildTestContent(),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: _buildTestContent(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTestContent() {
    return Column(
      children: [
        Expanded(
            child: Content(
              index: 0,
            )),
        SizedBox(
          height: 8,
        ),
        Expanded(
            child: Content(
              index: 0,
            )),
        SizedBox(
          height: 8,
        ),
        Expanded(
            flex: 3,
            child: Content(
              index: 1,
            )),
      ],
    );
  }
}

class LargeWithLayout extends StatelessWidget {
  const LargeWithLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Side(),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Logo(),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(child: TopBox()),
                    SizedBox(
                      width: 8,
                    ),
                    Logo(),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTestContent(),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: _buildTestContent(),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: _buildTestContent(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestContent() {
    return Column(
      children: [
        Expanded(
            child: Content(
              index: 0,
            )),
        SizedBox(
          height: 8,
        ),
        Expanded(
            child: Content(
              index: 0,
            )),
        SizedBox(
          height: 8,
        ),
        Expanded(
            flex: 3,
            child: Content(
              index: 1,
            )),
      ],
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      color: const Color(0xff9B9B9B),
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

class TopBox extends StatelessWidget {
  const TopBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: const Color(0xff9B9B9B),
    );
  }
}

const _kColors = [Color(0xffCBCBCB), Color(0xffEBEBEB)];

class Content extends StatelessWidget {
  final int index;

  const Content({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kColors[index],
    );
  }
}
