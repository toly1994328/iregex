main() {
  {
    print('=========tag1==========');
    // tag1
    RegExp regExp = RegExp('l{1,2}');
    String src = 'hello toly';
    List<RegExpMatch> matches = regExp.allMatches(src).toList();
    for (var match in matches) {
      print(
          "match(start: ${match.start},end: ${match.end}):结果 ${match.group(0)}");
    }
  }

  {
    print('=========tag2==========');
    // tag2
    RegExp regExp = RegExp('l{1,2}');
    String src = 'hello toly';
    List<RegExpMatch> matches = regExp.allMatches(src,3).toList();
    for (var match in matches) {
      print("match(start: ${match.start},end: ${match.end}):结果 ${match.group(0)}");
    }
  }

  {
    print('=========tag3==========');
    // tag3
    String str = 'll';
    String src = 'hello toly';
    List<Match> matches = str.allMatches(src).toList();
    for (var match in matches) {
      print("match(start: ${match.start},end: ${match.end}):结果 ${match.group(0)}");
    }
  }
}
