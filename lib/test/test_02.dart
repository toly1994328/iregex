main() {
  {
    print('=========tag1==========');
    // tag1
    RegExp regExp = RegExp('l{1,2}');
    String src = 'hello toly';
    Match? match = regExp.matchAsPrefix(src);
    print(
        "match(start: ${match?.start},end: ${match?.end}):结果 ${match?.group(0)}");
  }

  {
    print('=========tag2==========');
    // tag2
    RegExp regExp = RegExp('l{1,2}');
    String src = 'hello toly';
    Match? match = regExp.matchAsPrefix(src,3);
    print(
        "match(start: ${match?.start},end: ${match?.end}):结果 ${match?.group(0)}");
  }
}
