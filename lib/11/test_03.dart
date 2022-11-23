main() {
  {
    print('=========tag1==========');
    // tag1
    RegExp regExp = RegExp('w{2,3}.');
    String src = 'www.toly1994.com w{2,3}.';
    List<RegExpMatch> matches = regExp.allMatches(src).toList();
    for (var match in matches) {
      print("match(start: ${match.start},end: ${match.end}):结果 ${match.group(0)}");
    }
  }

  {
    print('=========tag2==========');
    // tag2
    RegExp regExp = RegExp(RegExp.escape('w{2,3}.'));
    String src = 'www.toly1994.com w{2,3}.';
    List<RegExpMatch> matches = regExp.allMatches(src).toList();
    for (var match in matches) {
      print("match(start: ${match.start},end: ${match.end}):结果 ${match.group(0)}");
    }
  }
  {
    print('=========tag3==========');
    // tag3
    print('${RegExp.escape('w{2,3}.')}');
  }
}
