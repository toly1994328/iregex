import 'dart:convert';

import 'package:flutter/services.dart';
import '../model/record.dart';
import '../../db_recode_repository.dart';

import '../dao/record_dao.dart';

class DefaultData {
  static Future<void> insertDefaultRecoder() async {
    DbRecoderRepository repository = DbRecoderRepository();
    String dataStr = await rootBundle.loadString('assets/data.json');
    List<dynamic> data = json.decode(dataStr).reversed.toList();
    List<Record> records =[];
    for(int i = 0;i<data.length;i++){
      await Future.delayed(Duration(milliseconds: 2));
      records.add( Record.i(title: data[i]['title'], content: data[i]['content']));
    }

    for (int i = 0; i < records.length; i++) {
      int a = await repository.insert(records[i]);
      print(a);
    }
  }
}
