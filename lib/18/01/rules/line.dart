//^[A-Z](.*?)\\w+


//注释符: #
import 'match_rule.dart';

class LineRule extends MatchRule  {
  const LineRule();
  @override
  Pattern get pattern => RegExp(r'^',multiLine: true);
}