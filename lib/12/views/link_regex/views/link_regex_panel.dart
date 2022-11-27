import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/custom/empty_panel.dart';
import '../../../components/custom/error_panel.dart';
import '../../../components/custom/loading_panel.dart';
import '../../../../app/iconfont/toly_icon.dart';
import '../bloc/link_regex_bloc.dart';
import '../bloc/link_regex_state.dart';
import 'link_regex_top_bar.dart';
import 'loaded_regex_panel.dart';


class RecommendPanel extends StatelessWidget {
  const RecommendPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RecommendTopBar(),
        Expanded(child: BlocBuilder<LinkRegexBloc,LinkRegexState>(
    builder: (_,state)=> _buildByState(state),
    ))
      ],
    );
  }

  Widget _buildByState(LinkRegexState state) {
    if (state is LoadingLinkRegexState) {
      return const LoadingPanel();
    }
    if (state is EmptyLinkRegexState) {
      return const EmptyPanel(
        data: "暂无链接正则",
        icon: TolyIcon.icon_empty_panel,
      );
    }
    if (state is ErrorLinkRegexState) {
      return ErrorPanel(
        data: "数据查询异常",
        icon: TolyIcon.zanwushuju,
        error: state.error,
        // onRefresh: bloc.loadRecord,
      );
    }
    if (state is LoadedLinkRegexState) {
      return LoadedRegexPanel(
        state: state,
      );
    }
    return const SizedBox();
  }
}
