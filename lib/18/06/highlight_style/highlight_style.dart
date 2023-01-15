import 'package:flutter/material.dart';
import '../rules/match_rule.dart';

abstract class HighlightStyle{

  const HighlightStyle();

  TextStyle mapStyleByMatchRule(MatchRule? rule);

  Color get backgroundColor;

}