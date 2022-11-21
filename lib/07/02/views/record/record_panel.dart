import 'package:flutter/material.dart';

import '../../repository/impl/db/model/record.dart';
import 'record_item.dart';

class RecordPanel extends StatelessWidget {
  final int activeId;
  final List<Record> records;
  final ValueChanged<Record> onSelectRecord;

  const RecordPanel({
    super.key,
    required this.activeId,
    required this.records,
    required this.onSelectRecord,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // controller: controller,
        itemCount: records.length,
        itemExtent: 70,
        itemBuilder: (c, index) => RecordItem(
              onTap: () => onSelectRecord(records[index]),
              record: records[index],
              active: records[index].id == activeId,
            ));
  }
}
