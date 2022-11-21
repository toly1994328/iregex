import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:regexp/app/iconfont/toly_icon.dart';

import '../../../../06/01/app/res/gap.dart';
import '../../components/custom/empty_panel.dart';
import '../../components/custom/error_panel.dart';
import '../../repository/impl/db/model/record.dart';
import '../../repository/impl/db_recode_repository.dart';
import '../../repository/recode_repository.dart';
import 'loaded_panel.dart';
import '../../components/custom/loading_panel.dart';
import 'record_state.dart';
import 'record_top_bar.dart';

class RecordPanel extends StatefulWidget {
  final ValueChanged<Record> onSelectRecord;

  const RecordPanel({super.key, required this.onSelectRecord});

  @override
  State<RecordPanel> createState() => _RecordPanelState();
}

class _RecordPanelState extends State<RecordPanel>
    with AutomaticKeepAliveClientMixin {
  final RecoderRepository repository = const DbRecoderRepository();

  RecordState state = const EmptyRecordState();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    List<Record> records = [];
    try {
      state = const LoadingRecordState();
      setState(() {});
      // int a = 1 ~/ 0; // 模拟异常
      // 模拟耗时
      await Future.delayed(const Duration(seconds: 1));
      records = await repository.search();
      if (records.isNotEmpty) {
        state = LoadedRecordState(
          activeRecordId: records.first.id,
          records: records,
        );
      } else {
        state = const EmptyRecordState();
      }
    } catch (e) {
      debugPrint(e.toString());
      state = ErrorRecordState(error: e.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const RecordTopBar(),
        Gap.dividerH,
        Expanded(child: _buildByState(state))
      ],
    );
  }

  void _selectRecord(Record record) {
    widget.onSelectRecord(record);
    setState(() {
      state = state.copyWith(
        activeRecordId: record.id,
      );
    });
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
        onRefresh: _loadData,
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
