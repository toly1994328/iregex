import '../../../repository/impl/db/model/record.dart';

abstract class RecordState {
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
}

class ErrorRecordState extends RecordState {
  final String error;

  const ErrorRecordState({required this.error});
}

class LoadedRecordState extends RecordState {
  final List<Record> records;
  final int activeRecordId;

  const LoadedRecordState({
    required this.records,
    required this.activeRecordId,
  });
}

class EmptyRecordState extends RecordState {
  const EmptyRecordState();
}

class LoadingRecordState extends RecordState {
  const LoadingRecordState();
}
