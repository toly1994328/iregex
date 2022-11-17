void main() {
  String src = '这是一段测试代码，我要测试测试，看能不能测试通过。';
  String pattern = '测试';
  src.splitMapJoin(pattern, onMatch: (Match match) {
    print("===onMatch:${match.group(0)}=======");
    return "";
  }, onNonMatch: (str) {
    print("===onNonMatch:$str=======");
    return "";
  });
}


