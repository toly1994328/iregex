//注释符: #
import 'match_rule.dart';

class KeywordsRule extends MatchRule  {
  final List<String> keywords;
  KeywordsRule(this.keywords);

  RegExp? _cacheRegex;

  RegExp get regex {
    _cacheRegex ??= RegExp(keywords.map((e) => '(\\b$e\\b)').join("|"));
    return _cacheRegex!;
  }

  @override
  Pattern get pattern => regex;
}