import 'match_rule.dart';

class MetaRule extends MatchRule  {
  const MetaRule();
  @override
  Pattern get pattern => RegExp(r'@\w+');
}