import 'package:flutter/material.dart';
import 'package:regexp/17/06/rules/match_rule.dart';

abstract class HighlightStyle{

  const HighlightStyle();

  TextStyle mapStyleByMatchRule(MatchRule? rule);

  Color get backgroundColor;

}