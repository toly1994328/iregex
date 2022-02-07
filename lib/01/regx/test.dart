main() {
  String src = '这是一段测试代码，我要测试测试，看能不能测试通过。';
  RegExp exp = RegExp('测试');
  List<RegExpMatch> allMatches = exp.allMatches(src).toList();

  List<String> part = [];
  if(allMatches.isEmpty) return;
  if(allMatches.length>2){
    part.add(allMatches[0].input.substring(0,allMatches[0].start));
    part.add(allMatches[0].input.substring(allMatches[0].start,allMatches[0].end));
    for (int index = 1; index < allMatches.length-1; index++) {
      RegExpMatch match = allMatches[index];
      RegExpMatch nextMatch = allMatches[index+1];
      RegExpMatch prevMatch = allMatches[index-1];
      int start = match.start;
      int end = match.end;
      int nextStart = nextMatch.end;
      int prevEnd = prevMatch.end;

      part.add(match.input.substring(prevEnd,start));
      part.add(match.input.substring(start,end));
      part.add(match.input.substring(end,nextStart));
      if(index==allMatches.length-2){
        part.add(match.input.substring(nextMatch.end));
      }
    }
  }else{
    part.add(allMatches[0].input.substring(0,allMatches[0].start));
    part.add(allMatches[0].input.substring(allMatches[0].start,allMatches[0].end));
    part.add(allMatches[0].input.substring(allMatches[0].end));
  }

  print(part.join(''));

  allMatches.asMap().forEach((i, match) {
    for (var j = 0; j <= match.groupCount; j++)
      print("group($i,$j) : ${match.group(j)}: ${match.start}-${match.end}");
    // print("${match.input.substring(start)}");
  });
}

// class Node{
//   final int position;
//   final Node? prev;
//   final Node? next;
//
//   Node({required this.start,required this.end, this.prev, this.next});
//
//   String value(String src){
//     if(prev==null){
//       return src.substring(0,);
//     }
//   }
//
// }

// 匹配
// 校验
