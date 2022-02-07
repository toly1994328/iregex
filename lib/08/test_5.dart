main() {
  String src = '光绪七年辛巳年八月初三（1881年9月25日），出生于浙江绍兴城内东昌坊新台门周家。幼名阿张，长根，长庚，学名周樟寿。';
  RegExp exp = RegExp(r'(\d{1,4})年(\d{1,2})月(\d{1,2})');
  List<RegExpMatch> allMatches = exp.allMatches(src).toList();

  for (var match in allMatches) {
    for (int i = 0; i <= match.groupCount; i++) {
      print("groupIndex:$i====match:${match.group(i)}");
    }
  }
}
