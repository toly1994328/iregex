main() {
  String src = '光绪七年辛巳年八月初三（1881年9月25日），出生于浙江绍兴城内东昌坊新台门周家。幼名阿张，长根，长庚，学名周樟寿。';
  const reg = r'(\d{1,4})年(?<月份>\d{1,2})月(\d{1,2})';
  RegExp exp = RegExp(reg);
  Iterable<RegExpMatch> allMatches = exp.allMatches(src);

  for (RegExpMatch match in allMatches) {
    String? month = match.namedGroup("月份");
    print("====match:$month");
    print("====groupNames:${match.groupNames}");

    // for (int i = 0; i <= match.groupCount; i++) {
    //   print("groupIndex:$i====match:${match.group(i)}");
    // }
  }
}
