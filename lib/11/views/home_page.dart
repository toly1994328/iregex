import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_foot.dart';
import '../views/record/bloc/record_state.dart';
import '../views/record/bloc/record_bloc.dart';

import '../app/res/cons.dart';
import '../app/res/gap.dart';
import '../components/navigation/views/left_tab_navigation.dart';
import '../parser/regex_parser.dart';
import 'content_text_panel.dart';
import 'home_top_bar.dart';
import 'left_nav_content.dart';
import 'match/bloc/bloc.dart';
import 'match/bloc/event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String regex = '';
  String src = '';
  // final RegexParser parser =  RegexParser();

  // InlineSpan get span => parser.formSpan(src, regex);
  PageController controller = PageController();

  //导航数据 - 激活 id
  int activeLeftNavId = 1;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecordBloc,RecordState>(
      listener: _listenRecordState,
      child: Scaffold(
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
                  ),
                  const Expanded(
                    child: ContentTextPanel(),
                  ),
                ],
              ),
            ),
            Gap.dividerH,
            const FootBar(),
          ],
        ),
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
    context.read<MatchBloc>().add(ChangeRegex(pattern: value));
  }


  void _listenRecordState(BuildContext context, RecordState state) {
    if(state is LoadedRecordState){
      String content = state.activeRecord.content;
      context.read<MatchBloc>().add(ChangeContent(content: content));
    }
    if(state is EmptyRecordState){
      context.read<MatchBloc>().add(const ChangeContent(content: ""));
    }
  }
}
