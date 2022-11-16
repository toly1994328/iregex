import 'dart:collection';

main() {
  String src = r'(((?:\d{1,4})年))(?:(\d{1,2}))月(\d{1,2})日';
  RegExp exp = RegExp(r'(?<=\()|(?<=\))|(?=\()|(?=\))');
  List<String> parts = src.split(exp);


  final Queue<int> stack = Queue();
  List<Position> positionList = [];
  for (int i = 0; i < parts.length; i++) {
    String target = parts[i];
    if (target == "(") {
      stack.addLast(i);
    }
    if (target == ")") {
      if (stack.isNotEmpty) {
        int matchIndex = stack.removeLast();
        positionList.add(Position(
          start: matchIndex,
          end: i,
        ));
      }
    }
  }
  print('===$positionList=======');
  positionList.sort((a,b)=>a.start-b.start);
  // print('===$positionList=======');
  print('===正则表达式:== ${src}=====');
  print('===分组情况=====');

  positionList.removeWhere((element) => element.part(parts).startsWith("?:"));

  positionList.forEach((element) {
    print(element.part(parts));
  });

}

class Position {
  final int start;
  final int end;

  Position({required this.start,required this.end});

  String part(List parts)=> parts.sublist(start+1,end).join();

  @override
  String toString() {
    return 'Position{start: $start, end: $end}';
  }
}


