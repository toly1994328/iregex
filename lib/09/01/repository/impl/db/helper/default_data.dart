import 'dart:convert';

import 'package:flutter/services.dart';
import '../model/record.dart';
import '../../db_recode_repository.dart';

import '../dao/record_dao.dart';

class DefaultData {
  static Future<void> insertDefaultRecoder() async {
    DbRecoderRepository repository = DbRecoderRepository();
    String dataStr = await rootBundle.loadString('assets/data.json');
    List<Record> records = json
        .decode(dataStr).reversed
        .map<Record>((e) => Record.i(title: e['title'], content: e['content']))
        .toList();
    for (int i = 0; i < records.length; i++) {
      int a = await repository.insert(records[i]);
      print(a);
    }
  }
}
