main() {
  {
    print('=========tag1==========');
    // tag1
    RegExp regExp = RegExp('l{1,2}');
    String src = 'hello toly';
    List<String> parts =src.split(regExp);
    print(parts); // [he, o to, y]
  }

  {
    print('=========tag2==========');
    // tag2

    String onMatch(Match match)=> '[${match.group(0)}]';
    String onNonMatch(String str)=> str;
    RegExp regExp = RegExp('l{1,2}');
    String src = 'hello toly';
    String result =src.splitMapJoin(regExp,onMatch:onMatch,onNonMatch:onNonMatch);
    print(result);
  }
  {
    print('=========tag3==========');
    // tag3
    String reg = r'^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$';
    RegExp regExp = RegExp(reg);
    print(regExp.hasMatch('187150793892')); // false
    print(regExp.hasMatch('18715079389')); // true
    print(regExp.hasMatch('48715079389')); // false
  }
}
