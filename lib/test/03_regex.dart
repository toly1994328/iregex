void main(){
  String src = 'toly1a9b9c4';
  RegExp regExp = RegExp(r'\d');
  List<String> parts = src.split(regExp);
  print(parts);
  print(parts.length);

  regExp.allMatches(src);
  Iterable<RegExpMatch> allMatches = regExp.allMatches(src);
  List<String?> matchResults = allMatches.map((e) => e.group(0)).toList();
  print(matchResults);
}
