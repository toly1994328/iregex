import 'package:flutter/foundation.dart';

import '../rules/match_rule.dart';

abstract class Language {
  final String name;

  Language(this.name){
    initRules();
  }

  final List<MatchRule> _rules = [];

  List<MatchRule> get rules => _rules;

  void reset() {
    _rules.clear();
  }

  void add(MatchRule rule) {
    _rules.add(rule);
  }

  @protected
  void initRules();

  List<String> get keywords;
}
