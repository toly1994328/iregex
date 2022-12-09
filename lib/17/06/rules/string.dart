import 'match_rule.dart';

abstract class StringMatchRule implements MatchRule {
  const StringMatchRule();
}

// 'text'
class SingleQuotesRule extends StringMatchRule{
  const SingleQuotesRule();

  @override
  Pattern get pattern => RegExp(r"'.*'");
}

// "text"
class DoubleQuotesRule extends StringMatchRule{
  const DoubleQuotesRule();
  @override
  Pattern get pattern => RegExp(r'".*"');
}

// """text"""
class ThreeQuotesRule extends StringMatchRule{
  const ThreeQuotesRule();
  @override
  Pattern get pattern => RegExp(r'"""(.|\n)*"""');
}

// '''text'''
class ThreeSingleQuotesRule extends StringMatchRule{
  const ThreeSingleQuotesRule();
  @override
  Pattern get pattern => RegExp(r"'''(.|\n)*'''");
}

// r"text"
class RawDoubleQuotesRule extends StringMatchRule{
  const RawDoubleQuotesRule();
  @override
  Pattern get pattern => RegExp(r'r".*"');
}

// r'text'
class RawSingleQuotesRule extends StringMatchRule {
  const RawSingleQuotesRule();
  @override
  Pattern get pattern => RegExp(r"r'.*'");
}
