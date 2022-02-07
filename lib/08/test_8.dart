main() {
  String src = 'I have a dream';
  RegExp exp = RegExp(r'a(?:[vm])');
  List<RegExpMatch> allMatches = exp.allMatches(src).toList();

  for (var match in allMatches) {
    print("groupCount:${match.groupCount}====");
  }
}
