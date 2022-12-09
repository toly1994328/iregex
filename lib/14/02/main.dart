import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  if(Platform.isMacOS||Platform.isWindows||Platform.isLinux){
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx,cts){
        if(cts.maxWidth<400){
          return const SmallWidthLayout();
        }
        if(cts.maxWidth>650){
          return const LargeWithLayout();
        }
        return const MiddleWidthLayout();
      },
    );
  }
}

class SmallWidthLayout extends StatelessWidget {
  const SmallWidthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children:  [
          const Expanded(child: TopBox()),
          const SizedBox(height: 8,),
          const Expanded(child: Content(index: 0,)),
          const SizedBox(height: 8,),
          const Expanded(child: Content(index: 0,)),
          const SizedBox(height: 8,),
          const Expanded(flex: 3, child: Content(index: 1,)),
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
              const Logo(),
              const SizedBox(width: 8,),
              const Expanded(child: TopBox()),
            ],
          ),
          const SizedBox(height: 8,),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildTestContent(),
                ),
                const SizedBox(width: 8,),
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
  Widget _buildTestContent(){
    return Column(
      children:  [
        const Expanded(child: Content(index: 0,)),
        const SizedBox(height: 8,),
        const Expanded(child: Content(index: 0,)),
        const SizedBox(height: 8,),
        const Expanded(flex: 3, child: Content(index: 1,)),
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
          const Side(),
          const SizedBox(width: 8,),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    const Logo(),
                    const SizedBox(width: 8,),
                    const Expanded(child: TopBox()),
                    const SizedBox(width: 8,),
                    const Logo(),
                  ],
                ),
                const SizedBox(height: 8,),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTestContent(),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: _buildTestContent(),
                      ),
                      const SizedBox(width: 8,),
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
  Widget _buildTestContent(){
    return Column(
      children:  [
        const Expanded(child: Content(index: 0,)),
        const SizedBox(height: 8,),
        const Expanded(child: Content(index: 0,)),
        const SizedBox(height: 8,),
        const Expanded(flex: 3, child: Content(index: 1,)),
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
      width: 56,
      color: const Color(0xff9B9B9B),
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

const _kColors=[Color(0xffCBCBCB),Color(0xffEBEBEB)];

class Content extends StatelessWidget {
  final int index;
  const Content({super.key,this.index=0});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kColors[index],
    );
  }
}


