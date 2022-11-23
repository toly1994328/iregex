import 'dart:convert';

import 'package:flutter/services.dart';

import '../../db_recode_repository.dart';
import '../model/record.dart';

class DefaultData {
  static Future<void> insertDefaultRecoder() async {
    DbRecoderRepository repository = DbRecoderRepository();
    String dataStr = await rootBundle.loadString('assets/data.json');
    List<dynamic> data = json.decode(dataStr).reversed.toList();
    List<Record> records = [];
    for (int i = 0; i < data.length; i++) {
      await Future.delayed(Duration(milliseconds: 2));
      records
          .add(Record.i(title: data[i]['title'], content: data[i]['content']));
    }

    for (int i = 0; i < records.length; i++) {
      int a = await repository.insert(records[i]);
      print(a);
    }
  }

  static Future<void> insertLoadMoreRecoder() async {
    DbRecoderRepository repository = DbRecoderRepository();
    int count = 200;
    List<Record> records = [];
    for (int i = 0; i < count; i++) {
      await Future.delayed(Duration(milliseconds: 2));
      records.add(Record.i(
          title: '测试小子 ${count - i}',
          content: "我这是第 ${count - i} 个数据，是为了测试加载更多功能，而创建的临时数据。请大家多多指教~"));
    }

    for (int i = 0; i < records.length; i++) {
      int a = await repository.insert(records[i]);
    }
  }
}
