import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexp/12/components/navigation/model/nav_tab.dart';

import '../app/res/cons.dart';
import '../app/res/gap.dart';
import '../components/navigation/views/left_tab_navigation.dart';
import '../views/record/bloc/record_bloc.dart';
import '../views/record/bloc/record_state.dart';
import 'content_text_panel.dart';
import 'home_foot.dart';
import 'home_top_bar.dart';
import 'left_nav_content.dart';
import 'link_regex/bloc/link_regex_bloc.dart';
import 'match/bloc/bloc.dart';
import 'match/bloc/event.dart';
import 'right_nav_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _leftCtrl = PageController();
  final PageController _rightCtrl = PageController();

  //导航数据 - 激活 id
  int activeLeftNavId = 1;
  int activeRightNavId = 4;

  List<NavTab> get leftTabs =>
      Cons.navTabs.where((e) => e.type == NavType.left).toList();

  List<NavTab> get rightTabs =>
      Cons.navTabs.where((e) => e.type == NavType.right).toList();

  @override
  void dispose() {
    _leftCtrl.dispose();
    _rightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecordBloc, RecordState>(
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
                  RailTabNavigation(
                    width: 22,
                    activeId: activeLeftNavId,
                    onSelect: _onSelectNav,
                    items: leftTabs,
                  ),
                  LeftNavContent(
                    controller: _leftCtrl,
                    activeIndex: activeLeftNavId,
                  ),
                  const Expanded(
                    child: ContentTextPanel(),
                  ),
                  RightNavContent(
                    controller: _rightCtrl,
                    activeIndex: activeRightNavId,
                  ),
                  RailTabNavigation(
                    width: 22,
                    textDirection: TextDirection.rtl,
                    activeId: activeRightNavId,
                    onSelect: _onSelectNav,
                    items: rightTabs,
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

  void _onSelectNav(NavTab nav) {
    if (nav.type == NavType.right) {
      if (activeRightNavId == nav.id) {
        activeRightNavId = 0;
      } else {
        activeRightNavId = nav.id;
        int index = rightTabs.indexOf(nav);
        _rightCtrl.jumpToPage(index);
      }
    } else {
      if (activeLeftNavId == nav.id) {
        activeLeftNavId = 0;
      } else {
        activeLeftNavId = nav.id;
        int index = leftTabs.indexOf(nav);
        _leftCtrl.jumpToPage(index);
      }
    }
    setState(() {});
  }

  void _onFileSelect(File file) {
    String content = file.readAsStringSync();
    context.read<MatchBloc>().add(ChangeContent(content: content));
  }

  void _onRegexChange(String value) {
    context.read<MatchBloc>().add(ChangeRegex(pattern: value));
  }

  void _listenRecordState(BuildContext context, RecordState state) {
    if (state is LoadedRecordState) {
      context
          .read<LinkRegexBloc>()
          .loadLinkRegex(recordId: state.activeRecordId);
      String content = state.activeRecord.content;
      context.read<MatchBloc>().add(ChangeContent(content: content));
    }
    if (state is EmptyRecordState) {
      context.read<MatchBloc>().add(const ChangeContent(content: ""));
    }
  }
}
