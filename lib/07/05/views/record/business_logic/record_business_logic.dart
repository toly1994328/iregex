import 'dart:async';

import 'package:flutter/material.dart';

import '../../../repository/recode_repository.dart';
import '../../../repository/impl/db_recode_repository.dart';
import '../../../repository/impl/db/model/record.dart';
import 'record_state.dart';

class RecordBusinessLogic{
  final RecoderRepository repository = const DbRecoderRepository();

  final StreamController<RecordState> _ctrl = StreamController();

  Stream<RecordState> get state => _ctrl.stream;

  RecordBusinessLogic();

  RecordState _lastState = const EmptyRecordState();

  void loadRecord() async{
    List<Record> records = [];
    try {
      _lastState = const LoadingRecordState();
      _ctrl.add(_lastState);
      // int a = 1 ~/ 0; // 模拟异常
      // 模拟耗时
      await Future.delayed(const Duration(seconds: 1));
      records = await repository.search();
      if (records.isNotEmpty) {
        _lastState = LoadedRecordState(
          activeRecordId: records.first.id,
          records: records,
        );
      } else {
        _lastState = const EmptyRecordState();
      }
    } catch (e) {
      debugPrint(e.toString());
      _lastState = ErrorRecordState(error: e.toString());
    }
    _ctrl.add(_lastState);
  }

  void select(int id){
    _ctrl.add(_lastState.copyWith(activeRecordId: id));
  }

  void dispose(){
    _ctrl.close();
  }

}