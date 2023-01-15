import 'comment.dart';
import 'string.dart';

abstract class MatchRule {
  const MatchRule();

  Pattern get pattern;
}
