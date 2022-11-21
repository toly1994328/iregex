import 'package:flutter/material.dart';

import '../../repository/impl/db/model/record.dart';
import '../../views/record/record_item.dart';
import 'bloc/record_state.dart';

class LoadedPanel extends StatelessWidget {
  final LoadedRecordState state;
  final ValueChanged<Record> onSelectRecord;

  const LoadedPanel({
    super.key,
    required this.state,
    required this.onSelectRecord,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.records.length,
      itemExtent: 70,
      itemBuilder: (c, index) => RecordItem(
        onTap: () => onSelectRecord(state.records[index]),
        record: state.records[index],
        active: state.records[index].id == state.activeRecordId,
      ),
    );
  }
}
