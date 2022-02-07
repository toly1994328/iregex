main() {
  String src = '鲁迅创作了《狂人日记》，是中国现代文学史第一篇白话文小说。'
      '《诗经》是中国古代诗歌开端，最早的一部诗歌总集。';
  RegExp exp = RegExp(r'《(.*?)》');
  List<RegExpMatch> allMatches = exp.allMatches(src).toList();

  for (var match in allMatches) {
    print("groupCount:${match.groupCount}====match:${match.group(1)}");
  }
}
