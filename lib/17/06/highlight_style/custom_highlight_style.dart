
import 'package:flutter/material.dart';

import '../rules/class_name.dart';
import '../rules/comment.dart';
import '../rules/key_words.dart';
import '../rules/match_rule.dart';
import '../rules/meta.dart';
import '../rules/num.dart';
import '../rules/string.dart';
import '../rules/type.dart';
import 'highlight_style.dart';

// dracula
//

//\w+(?=(\(.*[\{;]))

//方法签名 (\w+)( +)\w+( ?)(\((\w+(\?)?( +)\w+)?\))
//函数参数 \w+(\?)? \w+(,?)

//\(((,?))+\)
// magula
class CustomHighlightStyle extends HighlightStyle{

  const CustomHighlightStyle();

  @override
  TextStyle mapStyleByMatchRule(MatchRule? rule) {
    if (rule is CommentMatchRule) {
      return const TextStyle(color: Color(0xFF777777), fontSize: 14);
    }
    if (rule is StringMatchRule) {
      return const TextStyle(color: Color(0xFF005500), fontSize: 14);
    }
    if (rule is KeywordsRule) {
      return const TextStyle(color: Color(0xFF000080), fontSize: 14,fontWeight: FontWeight.w500);
    }
    if (rule is TypeRule) {
      return const TextStyle(color: Color(0xFF000080), fontSize: 14,fontWeight: FontWeight.w500);
    }
    if (rule is NumRule) {
      return const TextStyle(color: Color(0xFF880000), fontSize: 14);
    }
    if (rule is MetaRule) {
      return const TextStyle(color: Color(0xFF0000ee), fontSize: 14);
    }
    if (rule is ClassNameRule) {
      return const TextStyle(color: Color(0xFF000080), fontSize: 14,fontWeight: FontWeight.w500);
    }
    return const TextStyle(fontSize: 14);
  }

  @override
  Color get backgroundColor => Color(0xfff4f4f4);
}
