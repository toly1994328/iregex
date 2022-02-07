class MatchResult {
  final bool error;

  int get resultCount => results.length;
  final List<MatchInfo> results;

  MatchResult({this.error = false, this.results=const []});
}

class MatchInfo {
  final String content;
  final int groupNum;
  final String? groupName;
  final int startPos;
  final int matchIndex;
  final int endPos;
  final bool end;

  bool get isGroup => groupNum ==0;

  MatchInfo({
    required this.content,
    required this.groupNum,
     this.end =false,
    this.groupName,
    this.matchIndex=0,
    this.startPos = 0,
    this.endPos = 0,
  });
}
