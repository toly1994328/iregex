//^[A-Z](.*?)\\w+


//注释符: #
import 'match_rule.dart';

class ClassNameRule extends MatchRule  {
  const ClassNameRule();
  @override
  Pattern get pattern => RegExp(
      r'(?<=('
      r'(class +)|(enum +)|(mixin +)'
      r'))\w+');
}