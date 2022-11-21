import 'package:equatable/equatable.dart';

import '../../../repository/impl/db/model/record.dart';

abstract class RecordState extends Equatable {
  const RecordState();

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

  @override
  List<Object?> get props => [activeRecordId, records];
}

class EmptyRecordState extends RecordState {
  const EmptyRecordState();
}

class LoadingRecordState extends RecordState {
  const LoadingRecordState();
}
