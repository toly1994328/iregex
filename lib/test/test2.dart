import 'dart:collection';

main() {
  String src = r'光绪七年辛巳年八月初三（1881年9月25日），出生于浙江绍兴城内东昌坊新台门周家。幼名阿张，长根，长庚，学名周樟寿。';
  String reg = r'(((?:\d{1,4})年))(?:(\d{1,2}))月(\d{1,2})日';
  RegExp exp = RegExp(reg);

  List<RegExpMatch> allMatches = exp.allMatches(src).toList();
  for (var match in allMatches) {
    print('match.groupCount:${match.groupCount}');
    for (int i = 0; i <= match.groupCount; i++) {
      print("groupIndex:$i====match:${match.group(i)}====");
    }
  }
}
//groupIndex:0====match:1881年9月25日====
// groupIndex:1====match:1881年9====
// groupIndex:2====match:1881年====
// groupIndex:3====match:1881====
// groupIndex:4====match:9====
// groupIndex:5====match:25日====
// groupIndex:6====match:25====
