import 'package:equatable/equatable.dart';

import '../model/match_info.dart';

abstract class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object?> get props => [];
}

class ChangeRegex extends MatchEvent {
  final String pattern;
  const ChangeRegex({
    required this.pattern,
  });
}

class ChangeContent extends MatchEvent{
  final String content;
  const ChangeContent({
    required this.content,
  });
}


class HoverMatchRegex extends MatchEvent {
  final MatchInfo matchInfo;

  const HoverMatchRegex({
    required this.matchInfo,
  });
}
