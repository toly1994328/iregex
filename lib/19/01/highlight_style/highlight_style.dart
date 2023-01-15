import 'package:flutter/material.dart';
import '../rules/match_rule.dart';
import 'highlight.dart';
import '../rules/class_name.dart';
import '../rules/comment.dart';
import '../rules/key_words.dart';
import '../rules/meta.dart';
import '../rules/num.dart';
import '../rules/string.dart';
import '../rules/type.dart';
abstract class HighlightStyle{

  HighlightStyle();

  TextStyle mapStyleByMatchRule(MatchRule? rule);

  Color get backgroundColor;
}

// dracula
//

//\w+(?=(\(.*[\{;]))

//方法签名 (\w+)( +)\w+( ?)(\((\w+(\?)?( +)\w+)?\))
//函数参数 \w+(\?)? \w+(,?)

//\(((,?))+\)
// magula
class CustomHighlightStyle extends HighlightStyle{
  Highlight highlight;
  CustomHighlightStyle({this.highlight=Highlight.magula});

  @override
  TextStyle mapStyleByMatchRule(MatchRule? rule) {
    if (rule is CommentMatchRule) return highlight.commentStyle;
    if (rule is StringMatchRule) return highlight.stringStyle;
    if (rule is KeywordsRule) return highlight.keywordsStyle;
    if (rule is TypeRule) return highlight.typeStyle;
    if (rule is NumRule) return highlight.numberStyle;
    if (rule is MetaRule) return highlight.metaStyle;
    if (rule is ClassNameRule) return highlight.classNameStyle;
    return highlight.noneStyle;
  }

  @override
  Color get backgroundColor => highlight.backgroundColor;
}
