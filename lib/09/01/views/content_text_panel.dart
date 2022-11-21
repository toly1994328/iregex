import 'package:flutter/material.dart';

class ContentTextPanel extends StatelessWidget {
  final InlineSpan span;
  const ContentTextPanel({
    Key? key,
    required this.span,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Text.rich(span),
      ),
    );
  }
}
