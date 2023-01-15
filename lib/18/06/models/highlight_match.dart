
import '../rules/match_rule.dart';


class HighlightMatch {
  final MatchRule rule;
  final String value;
  final int start;
  final int end;

  const HighlightMatch(this.rule, this.value, this.start, this.end);
}

