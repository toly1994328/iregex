import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:regexp/app/iconfont/toly_icon.dart';

import '../../../../06/01/app/res/gap.dart';
import '../../components/custom/empty_panel.dart';
import '../../components/custom/error_panel.dart';
import '../../components/custom/loading_panel.dart';
import '../../repository/impl/db/model/record.dart';
import 'business_logic/record_business_logic.dart';
import 'business_logic/record_state.dart';
import 'loaded_panel.dart';
import 'record_top_bar.dart';

class RecordPanel extends StatefulWidget {
  final ValueChanged<Record> onSelectRecord;

  const RecordPanel({super.key, required this.onSelectRecord});

  @override
  State<RecordPanel> createState() => _RecordPanelState();
}

class _RecordPanelState extends State<RecordPanel>
    with AutomaticKeepAliveClientMixin {
  RecordBusinessLogic logic = RecordBusinessLogic();

  @override
  void initState() {
    super.initState();
    logic.loadRecord();
  }

  @override
  void dispose() {
    logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const RecordTopBar(),
        Gap.dividerH,
        Expanded(
          child: StreamBuilder<RecordState>(
            initialData: const EmptyRecordState(),
            stream: logic.state,
            builder: (_, snap) => _buildByState(snap.data!),
          ),
        )
      ],
    );
  }

  void _selectRecord(Record record) {
    widget.onSelectRecord(record);
    logic.select(record.id);
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
        onRefresh: logic.loadRecord,
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
