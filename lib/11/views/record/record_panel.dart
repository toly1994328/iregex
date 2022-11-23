import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexp/app/iconfont/toly_icon.dart';

import '../../../../06/01/app/res/gap.dart';
import '../../components/custom/empty_panel.dart';
import '../../components/custom/error_panel.dart';
import '../../components/custom/loading_panel.dart';
import '../../repository/impl/db/model/record.dart';
import 'bloc/record_bloc.dart';
import 'bloc/record_state.dart';
import 'loaded_panel.dart';
import 'record_top_bar.dart';

class RecordPanel extends StatefulWidget {
  const RecordPanel({super.key});

  @override
  State<RecordPanel> createState() => _RecordPanelState();
}

class _RecordPanelState extends State<RecordPanel> with AutomaticKeepAliveClientMixin {

  RecordBloc get bloc => context.read<RecordBloc>();

  @override
  void initState() {
    super.initState();
    bloc.loadRecord();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const RecordTopBar(),
        Gap.dividerH,
        Expanded(
          child: BlocBuilder<RecordBloc,RecordState>(
            builder: (_,state)=> _buildByState(state),
          )
        )
      ],
    );
  }

  void _selectRecord(Record record) {
    bloc.select(record.id);
  }

  Widget _buildByState(RecordState state) {
    if (state is LoadingRecordState) {
      return const LoadingPanel();
    }
    if (state is EmptyRecordState) {
      return const EmptyPanel(
        data: "记录数据为空",
        icon: TolyIcon.icon_empty_panel,
      );
    }
    if (state is ErrorRecordState) {
      return ErrorPanel(
        data: "数据查询异常",
        icon: TolyIcon.zanwushuju,
        error: state.error,
        onRefresh: bloc.loadRecord,
      );
    }
    if (state is LoadedRecordState) {
      return LoadedPanel(
        state: state,
        onSelectRecord: _selectRecord,
      );
    }
    return const SizedBox();
  }

  @override
  bool get wantKeepAlive => true;
}
