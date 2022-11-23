import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../parser/regex_parser.dart';
import 'event.dart';
import 'state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  RegexParser parser = RegexParser();

  MatchBloc() : super(const MatchSuccess()) {
    on<ChangeRegex>(_onChangeRegex);
    on<ChangeContent>(_onChangeContent);
    on<HoverMatchRegex>(_onHoverMatchRegex);
  }

  void _onChangeRegex(ChangeRegex event, Emitter<MatchState> emit) async {
    MatchState match = parser.match(
      state.content,
      event.pattern,
      state.config,
    );
    emit(match);
  }

  void _onHoverMatchRegex(HoverMatchRegex event, Emitter<MatchState> emit) {
    MatchState match = parser.match(
      state.content,
      state.pattern,
      state.config,
      activeMatch: event.matchInfo,
    );
    emit(match);
  }

  FutureOr<void> _onChangeContent(
      ChangeContent event, Emitter<MatchState> emit) {
    MatchState match = parser.match(
      event.content,
      state.pattern,
      state.config,
    );
    emit(match);
  }
}
