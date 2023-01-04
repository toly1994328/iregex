import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/impl/db/model/record.dart';
import '../../../repository/impl/db_recode_repository.dart';
import '../../../repository/recode_repository.dart';
import 'record_state.dart';

enum LoadType {
  load, // 加载
  refresh, // 更新
  delete, // 删除
  edit, // 编辑
  add, // 添加
  more, // 加载更多
}

class RecordBloc extends Cubit<RecordState> {
  final RecoderRepository repository = const DbRecoderRepository();

  RecordBloc() : super(const EmptyRecordState());

  void loadRecord({
    LoadType operation = LoadType.load,
  }) async {
    RecordState state;
    try {
      if (operation == LoadType.load) {
        emit(const LoadingRecordState());
        // 模拟耗时
        await Future.delayed(const Duration(milliseconds: 500));
      }
      // int a = 1 ~/ 0; // 模拟异常
      List<Record> records = [];
      if (operation == LoadType.more) {
        records = await _loadMore();
      } else if (operation == LoadType.load) {
        records = await repository.search();
      } else {
        records = await _loadRefresh();
      }
      if (records.isNotEmpty) {
        state = LoadedRecordState(
          activeRecordId: _handleActiveId(records, operation),
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

  Future<List<Record>> _loadRefresh() async {
    int length = 0;
    if (state is! LoadedRecordState) {
      length = 25;
    } else {
      LoadedRecordState oldState = state as LoadedRecordState;
      length = oldState.records.length;
    }

    List<Record> records = await repository.search(
      page: 1,
      pageSize: length,
    );
    return records;
  }

  Future<List<Record>> _loadMore() async {
    List<Record> records = [];
    if (state is! LoadedRecordState) return records;
    LoadedRecordState oldState = state as LoadedRecordState;
    int pageSize = 25;
    int pageIndex = oldState.records.length ~/ pageSize;
    if (pageIndex < 1) return oldState.records;
    List<Record> newRecords = await repository.search(
      page: pageIndex + 1,
      pageSize: pageSize,
    );
    if (newRecords.isNotEmpty) {
      print("===加载第 ${pageIndex + 1} 页======${pageSize} 条数据========");
      records = List.of(oldState.records)..addAll(newRecords);
    } else {
      records = oldState.records;
    }
    return records;
  }

  int _handleActiveId(List<Record> records, LoadType operation) {
    RecordState state = this.state;
    int? activeId = state.active?.id;
    switch (operation) {
      case LoadType.load:
      case LoadType.add:
        return records.first.id;
      case LoadType.refresh:
      case LoadType.more:
      case LoadType.edit:
        return activeId ?? records.first.id;
      case LoadType.delete:
        if (state is LoadedRecordState) {
          return state.records[state.nextActiveId].id;
        }
        return -1;
    }
  }

  Future<bool> deleteById(int id) async {
    int result = 0;
    try {
      result = await repository.deleteById(id);
    } catch (e) {
      return false;
    }
    if (result > 0) {
      loadRecord(operation: LoadType.delete);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteAll() async {
    try {
      await repository.deleteAll();
    } catch (e) {
      return false;
    }
    loadRecord(operation: LoadType.load,);
    return true;
  }

  Future<bool> insert(String title, String content) async {
    int result = await repository.insert(Record.i(
      title: title,
      content: content,
    ));
    if (result > 0) {
      loadRecord(operation: LoadType.add);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> update(Record record) async {
    int result = await repository.update(record);
    if (result > 0) {
      loadRecord(operation: LoadType.refresh);
      return true;
    } else {
      return false;
    }
  }

  void select(int id) {
    emit(state.copyWith(activeRecordId: id));
  }
}
