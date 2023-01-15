import 'package:flutter/material.dart';

import 'map_data.dart';

class HighlightMatch {
  final HighlightType type;
  final String value;
  final int start;
  final int end;

  const HighlightMatch(this.type, this.value, this.start, this.end);

  TextStyle get style => kHighlightMap[type]!;
}

class LinkMatch extends HighlightMatch {
  final String url;

  const LinkMatch({
    required this.url,
    required String value,
    required int start,
    required int end,
  }) : super(HighlightType.link, value, start, end);
}

class ImageMatch extends HighlightMatch {
  final String url;

  const ImageMatch({
    required this.url,
    required String value,
    required int start,
    required int end,
  }) : super(HighlightType.image, value, start, end);
}