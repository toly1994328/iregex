main() {
  String src = 'I have a dream';
  RegExp  exp = RegExp(r'a');
//      if(matchStr.isEmpty){
//         part.add('*');
//       }
  List<RegExpMatch> allMatches = exp.allMatches(src).toList();

  for (var element in allMatches) {
    print("=====start:${element.start}====end:${element.end}");
  }

  List<String> part = [];
    int start = 0;
    int end = 0;
    for(int i=0;i<allMatches.length;i++){
      RegExpMatch? prevMatch;
      if(i>0){
        prevMatch = allMatches[i-1];
      }
      RegExpMatch match = allMatches[i];
      start = prevMatch?.end??0;
      end = match.start;
      String noMatchStr =match.input.substring(start,end);
      part.add(noMatchStr);

      start = match.start;
      end = match.end;
      String matchStr = match.input.substring(start,end);
      part.add(matchStr);

      if(i==allMatches.length-1){
        String tail = match.input.substring(allMatches.last.end);
        part.add(tail);
      }
    }
    print(part.join());
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
