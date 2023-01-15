//^[A-Z](.*?)\\w+


//注释符: #
import 'match_rule.dart';

class TypeRule extends MatchRule  {
  const TypeRule();
  @override
  Pattern get pattern => RegExp(
      r'\b([A-Z]\w+(?=[ <\(\?\.])|'
      r'(int)|(double)|(num)|(float)|(char)'
      r')\b');
}