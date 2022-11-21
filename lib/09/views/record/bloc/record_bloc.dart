import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/impl/db/model/record.dart';
import '../../../repository/impl/db_recode_repository.dart';
import '../../../repository/recode_repository.dart';
import 'record_state.dart';

class RecordBloc extends Cubit<RecordState> {
  final RecoderRepository repository = const DbRecoderRepository();

  RecordBloc() : super(const EmptyRecordState());

  void loadRecord({bool refresh = false}) async {
    RecordState state;
    try {
      if(!refresh){
        emit(const LoadingRecordState());
        // 模拟耗时
        await Future.delayed(const Duration(seconds: 1));
      }
      // int a = 1 ~/ 0; // 模拟异常

      List<Record> records = await repository.search();
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
    emit(state);
  }

  void select(int id) {
    emit(state.copyWith(activeRecordId: id));
  }
}
