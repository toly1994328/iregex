main() {
  String src = 'I have a dream';
  RegExp exp = RegExp(r'a[vm]');
  Iterable<RegExpMatch> allMatches = exp.allMatches(src);
  for (RegExpMatch match in allMatches) {
    print("groupCount:${match.groupCount}====match:${match.group(0)}");
  }
}
