import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

import '../model/match_info.dart';
import '../model/regexp_config.dart';

abstract class MatchState extends Equatable {
  final String content;
  final String pattern;
  final RegExpConfig config;

  const MatchState({
    this.content = '',
    this.pattern = '',
    this.config = const RegExpConfig(),
  });

   InlineSpan get inlineSpan{
     if(this is MatchSuccess){
       return (this as MatchSuccess).span;
     }
     return TextSpan(text: content);
   }

  @override
  List<Object?> get props => [];
}

class MatchSuccess extends MatchState {
  final List<MatchInfo> results;
  final int matchTime;
  final InlineSpan span;

  int get matchCount => results.where((element) => !element.isGroup).length;

  int get groupCount => results.where((element) => element.isGroup).length;

  const MatchSuccess({
    this.results = const [],
    this.matchTime = 0,
    this.span = const TextSpan(text: ''),
    super.content,
    super.pattern,
    super.config
  });

  @override
  List<Object?> get props => [results, span];
}

class MatchError extends MatchState {
  final String error;

  const MatchError({
    required this.error,
    super.content,
    super.pattern,
    super.config
  });

  @override
  List<Object?> get props => [error];
}
