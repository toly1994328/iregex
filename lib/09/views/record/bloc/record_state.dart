import 'package:equatable/equatable.dart';

import '../../../repository/impl/db/model/record.dart';

abstract class RecordState extends Equatable {
  const RecordState();

  Record? get activeRecord {
    RecordState state = this;
    if (state is LoadedRecordState) {
      return state.activeRecord;
    }
    return null;
  }

  RecordState copyWith({
    List<Record>? records,
    int? activeRecordId,
  }) {
    RecordState state = this;
    if (state is LoadedRecordState) {
      return LoadedRecordState(
        records: records ?? state.records,
        activeRecordId: activeRecordId ?? state.activeRecordId,
      );
    } else {
      return state;
    }
  }

  @override
  List<Object?> get props => [];
}

class ErrorRecordState extends RecordState {
  final String error;

  const ErrorRecordState({required this.error});

  @override
  List<Object?> get props => [error];
}

class LoadedRecordState extends RecordState {
  final List<Record> records;
  final int activeRecordId;

  const LoadedRecordState({
    required this.records,
    required this.activeRecordId,
  });

  Record get activeRecord => records.singleWhere((e) => e.id == activeRecordId);

  int get nextActiveId {
    int targetIndex = records.indexOf(activeRecord);
    if(targetIndex==records.length-1){
      // 说明是最后一个，取前一个为激活索引
      return targetIndex - 1;
    }
    // 说明在中间，取下一个元素索引
    return targetIndex + 1;
  }

  @override
  List<Object?> get props => [activeRecordId, records];
}

class EmptyRecordState extends RecordState {
  const EmptyRecordState();
}

class LoadingRecordState extends RecordState {
  const LoadingRecordState();
}
