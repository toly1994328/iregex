import 'dart:io';

import 'package:flutter/material.dart';

import '../app/res/cons.dart';
import '../app/res/gap.dart';

import '../components/navigation/views/left_tab_navigation.dart';
import '../parser/regex_parser.dart';
import '../repository/impl/db/model/record.dart';
import '../repository/impl/db_recode_repository.dart';
import '../repository/recode_repository.dart';
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
  String src = '';

  final RegexParser parser = const RegexParser(multiLine: true);

  InlineSpan get span => parser.formSpan(src, regex);

  //导航数据 - 激活 id
  int activeLeftNavId = 1;

  final RecoderRepository repository = const DbRecoderRepository();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // 记录数据
  List<Record> records =[];
  int activeRecord = -1;

  void _loadData() async{
    records = await repository.search();
    if(records.isNotEmpty){
      activeRecord = records.first.id;
      src = records.first.content;
    }
    setState(() {

    });
  }

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
                  activeIndex:activeLeftNavId,
                  activeRecordId: activeRecord,
                  records: records,
                  onTap: _onSelectContent,
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

  void _onSelectContent(Record value) {
    src = value.content;
    activeRecord = value.id;
    setState(() {

    });
  }
}

