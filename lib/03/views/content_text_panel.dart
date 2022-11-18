import 'package:flutter/material.dart';
import 'package:regexp/02/01_base/parser/regex_parser.dart';

class ContentTextPanel extends StatelessWidget {
  final InlineSpan span;
  const ContentTextPanel({
    Key? key,
    required this.span,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Text.rich(span),
    );
  }
}
