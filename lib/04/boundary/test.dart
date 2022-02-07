main(){
  final List<String> sList = [' ','\t','\v','\n','\r','\f'];

  String src = "I have a dream";
  // String src = """I have a dream""";
  // String src = """I have a dream""";
  RegExp  regExp = RegExp(r'a??',multiLine: false);
  List<RegExpMatch> allMatches = regExp.allMatches(src).toList();
  var parts = src.split(regExp);
  print(parts);
  // parts.forEach((element) {
  //   print("length:${element.length}");
  // });
  print("parts.length:${parts.length}");
  print("allMatches.length:${allMatches.length}");
  print(allMatches.map((e) {
    print("${e.start}====${e.end}===${src.substring(e.start,e.end)}");
    return e.group(0);
  }).toList());

  String result = "";
  //修正 首部匹配空字符
  if (allMatches.isNotEmpty) {
    bool matchStart = allMatches.first.start == 0 &&
        (allMatches.first.group(0)?.isEmpty ?? false);
    if (matchStart) {
      result+="*";
    }
  }

  if (parts.length > 1) {
    for (int i = 0; i < parts.length; i++) {
      result+=parts[i];
      if (i != parts.length - 1) {
        String? matchStr = allMatches[i].group(0);
        if (matchStr != null) {
          if (matchStr.isNotEmpty) {
            result+= allMatches[i].group(0)??'';
            if(sList.contains(matchStr)){
              result+="&";
            }
          } else {
            result+="*";
          }
        }
      }
    }
  } else {
    result =  src;
  }

  //修正 尾部匹配空字符
  if (allMatches.isNotEmpty) {
    bool matchEnd = allMatches.last.end == src.length &&
        (allMatches.first.group(0)?.isEmpty ?? false);
    if (matchEnd) {
      result+="*";
    }
  }
  print(result);
}

//[I,  , h, v, e,  ,  , d, r, e, m]
//[, , , a, , , , a, , , , , a, , ]