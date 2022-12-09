import 'match_rule.dart';

class NumRule extends MatchRule  {
  const NumRule();
  @override
  Pattern get pattern => RegExp(r'(0x\w+)|\b([-]?(\d+\.\d+)|(\d+))([f,e]?\d*)\b');
}