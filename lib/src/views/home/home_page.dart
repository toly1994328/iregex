import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/res/cons.dart';
import '../../app/res/gap.dart';
import '../../components/navigation/model/nav_tab.dart';
import '../../components/navigation/views/left_tab_navigation.dart';
import 'content_text_panel.dart';
import 'home_foot.dart';
import 'home_top_bar.dart';
import 'left_nav_content.dart';
import 'package:regexp/src/models/models.dart';
import 'package:regexp/src/blocs/blocs.dart';
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
    Brightness brightness = Theme.of(context).brightness;
    bool isDark = brightness ==Brightness.dark;
    Color bgColor = isDark?Colors.redAccent:Colors.white;
    return BlocListener<RecordBloc, RecordState>(
      listenWhen: (p, n) => p.activeRecord?.id != n.activeRecord?.id,
      listener: _listenRecordState,
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            HomeTopBar(
              onSaveLinkRegx: _onSaveLinkRegex,
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
    print("=======_listenRecordState=${state.runtimeType}===========");
    LinkRegexBloc linkRegexBloc = context.read<LinkRegexBloc>();
    MatchBloc matchBloc = context.read<MatchBloc>();
    if (state is LoadedRecordState) {
      linkRegexBloc.loadLinkRegex(recordId: state.activeRecordId);
      String content = state.activeRecord.content;
      matchBloc.add(ChangeContent(content: content));
    }
    if (state is EmptyRecordState) {
      linkRegexBloc.loadLinkRegex(recordId: -1);
      matchBloc.add(const ChangeContent(content: ""));
    }
  }

  void _onSaveLinkRegex() async {
    String regex = context.read<MatchBloc>().state.pattern;
    Record? record = context.read<RecordBloc>().state.activeRecord;
    LinkRegexBloc linkRegexBloc = context.read<LinkRegexBloc>();
    if (record != null) {
      await linkRegexBloc.repository.insert(LinkRegex.i(
        recordId: record.id,
        regex: regex,
      ));
      linkRegexBloc.loadLinkRegex(recordId: record.id);
    }
  }
}
