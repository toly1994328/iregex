import 'package:flutter/material.dart';

import '../models/highlight_match.dart';

class MarkdownImageWidget extends StatelessWidget {
  final ImageMatch match;

  const MarkdownImageWidget({super.key,required this.match});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(match.url),
        ),
        Text(match.value,style: match.style,)
      ],
    );
  }
}
