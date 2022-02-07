main() {
  String src = 'I have a dream';
  RegExp  exp = RegExp(r'a?',multiLine: false);

  List<RegExpMatch> allMatches = exp.allMatches(src).toList();

  List<String> part = [];
  if(allMatches.isEmpty) return;
  if(allMatches.length>2){
    String p= allMatches[0].input.substring(0,allMatches[0].start);
    String c= allMatches[0].input.substring(allMatches[0].start,allMatches[0].end);
    if(p.isEmpty){
      part.add("*");
    }else{
      part.add(p);
    }

    if(c.isEmpty){
      part.add("&");
    }else{
      part.add(c);
    }

    for (int index = 1; index < allMatches.length-1; index++) {

      RegExpMatch match = allMatches[index];
      RegExpMatch nextMatch = allMatches[index+1];
      RegExpMatch prevMatch = allMatches[index-1];
      int start = match.start;
      int end = match.end;
      int nextStart = nextMatch.end;
      int prevEnd = prevMatch.end;

      print("index:$index=====${allMatches.length}=");

      if(index==allMatches.length-2){
        var e = match.input.substring(nextMatch.end);
        print("e:$e======");
        if(e.isEmpty){
          part.add("*");

        }else{
          part.add(e);

        }
      }

      var p = match.input.substring(prevEnd,start);
      var c = match.input.substring(start,end);
      var n = match.input.substring(end,nextStart);

      if(p.isEmpty){
        part.add("*");
        continue;
      }else{
        part.add(p);
      }

      if(c.isEmpty){
        part.add("&");
        continue;
      }else{
        part.add(c);
      }

      if(n.isEmpty){
        part.add("*");
        continue;
      }else{
        part.add(n);
      }


    }
  }else{
    var p = allMatches[0].input.substring(0,allMatches[0].start);
    var c = allMatches[0].input.substring(allMatches[0].start,allMatches[0].end);
    var n = allMatches[0].input.substring(allMatches[0].end);
    print('c:========$c');
    if(p.isEmpty){
      part.add("*");
    }else{
      part.add(p);
    }

    if(c.isEmpty){
      part.add("&");
    }else{
      part.add(c);
    }

    if(n.isEmpty){
      part.add("*");
    }else{
      part.add(n);
    }
  }

  print(part.join(''));
  print('allMatches:${allMatches.length}');

  allMatches.asMap().forEach((i, match) {
    // for (var j = 0; j <= match.groupCount; j++)
      // print("group($i,$j) : ${match.group(j)}: ${match.start}-${match.end}====${src.substring(match.start,match.end)}");
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
