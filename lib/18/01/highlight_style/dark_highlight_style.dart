
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

// agate
class DarkHighlightStyle extends HighlightStyle{

  const DarkHighlightStyle();

  @override
  TextStyle mapStyleByMatchRule(MatchRule? rule) {
    if (rule is CommentMatchRule) {
      return const TextStyle(color: Color(0xFF888888), fontSize: 14);
    }
    if (rule is StringMatchRule) {
      return const TextStyle(color: Color(0xFFa2fca2), fontSize: 14);
    }

    if (rule is KeywordsRule) {
      return const TextStyle(color: Color(0xFFffffaa), fontSize: 14);
    }
    if (rule is TypeRule) {
      return const TextStyle(color: Color(0xFFfcc28c), fontSize: 14);
    }
    if (rule is NumRule) {
      return const TextStyle(color: Color(0xFFfcc28c), fontSize: 14);
    }
    if (rule is MetaRule) {
      return const TextStyle(color: Color(0xFFfc9b9b), fontSize: 14);
    }
    if (rule is ClassNameRule) {
      return const TextStyle(color: Color(0xFFffffaa), fontSize: 14,fontWeight: FontWeight.bold);
    }
    return const TextStyle(color:Colors.white, fontSize: 14);
  }

  @override
  Color get backgroundColor => Color(0xff333333);
}
