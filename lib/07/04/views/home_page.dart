import 'dart:io';

import 'package:flutter/material.dart';

import '../app/res/cons.dart';
import '../app/res/gap.dart';
import '../components/navigation/views/left_tab_navigation.dart';
import '../parser/regex_parser.dart';
import '../repository/impl/db/model/record.dart';
import 'content_text_panel.dart';
import 'home_top_bar.dart';
import 'left_nav_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String regex = '';
  String src =
      '中国陆地面积约960万平方千米，东部和南部大陆海岸线1.8万多千米，内海和边海的水域面积约470多万平方千米。海域分布有大小岛屿7600多个，其中台湾岛最大，面积35798平方千米 。中国同14国接壤，与8国海上相邻。省级行政区划为23个省、5个自治区、4个直辖市、2个特别行政区。';

  final RegexParser parser = const RegexParser(multiLine: true);

  InlineSpan get span => parser.formSpan(src, regex);
  PageController controller = PageController();

  //导航数据 - 激活 id
  int activeLeftNavId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeTopBar(
            onRegexChange: _onRegexChange,
            onFileSelect: _onFileSelect,
          ),
          Gap.dividerH,
          Expanded(
            child: Row(
              children: [
                LeftTabNavigation(
                  width: 22,
                  activeId: activeLeftNavId,
                  onSelect: _onSelectNav,
                  items: Cons.leftNav,
                ),
                LeftNavContent(
                  controller: controller,
                  activeIndex: activeLeftNavId,
                  onSelectRecord: _onSelectRecord,
                ),
                Expanded(
                  child: ContentTextPanel(
                    span: span,
                  ),
                ),
              ],
            ),
          ),
          Gap.dividerH,
          // FootBar(),
        ],
      ),
    );
  }

  void _onSelectNav(nav) {
    if (activeLeftNavId == nav.id) {
      activeLeftNavId = 0;
    } else {
      activeLeftNavId = nav.id;
      controller.jumpToPage(activeLeftNavId - 1);
    }
    setState(() {});
  }

  void _onFileSelect(File file) {
    src = file.readAsStringSync();
    setState(() {});
  }

  void _onRegexChange(String value) {
    regex = value;
    setState(() {});
  }

  void _onSelectRecord(Record value) {
    src = value.content;
    setState(() {});
  }
}
