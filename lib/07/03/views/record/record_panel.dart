import 'package:flutter/material.dart';
import '../../repository/impl/db_recode_repository.dart';
import '../../repository/recode_repository.dart';

import '../../repository/impl/db/model/record.dart';
import 'record_item.dart';

class RecordPanel extends StatefulWidget {
  final ValueChanged<Record> onSelectRecord;

  const RecordPanel({super.key, required this.onSelectRecord});

  @override
  State<RecordPanel> createState() => _RecordPanelState();
}

class _RecordPanelState extends State<RecordPanel> with AutomaticKeepAliveClientMixin {
  final RecoderRepository repository = const DbRecoderRepository();

  List<Record> records = [];
  int activeRecordId = -1;

  @override
  void initState() {
    print("====_RecordPanelState#initState=========");
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    print("====_RecordPanelState#dispose=========");
    super.dispose();
  }

  void _loadData() async {
    records = await repository.search();
    if (records.isNotEmpty) {
      activeRecordId = records.first.id;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
        itemCount: records.length,
        itemExtent: 70,
        itemBuilder: (c, index) => RecordItem(
            onTap: () => _selectRecord(records[index]),
            record: records[index],
            active: records[index].id == activeRecordId));
  }

  void _selectRecord(Record record) {
    widget.onSelectRecord(record);
    setState(() {
      activeRecordId = record.id;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
