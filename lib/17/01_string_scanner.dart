import 'package:string_scanner/string_scanner.dart';

void main() {
  // foo1();
  // foo2();
  // foo3();
  foo4();
}

void foo1(){
  StringScanner scanner = StringScanner("toly 1994,hello!");

  while (!scanner.isDone) {
    print("=====${scanner.position}=============");
    scanner.position++;
  }
}

void foo2(){
  String src = "toly 1994,hello!";
  RegExp regExp = RegExp(r'\d+');
  Match? match = regExp.matchAsPrefix(src,);
  print("=====match:$match=========");
}

void foo3(){
  String src = "toly 1994,hello!";
  RegExp regExp = RegExp(r'\d+');
  Match? match = regExp.matchAsPrefix(src,5);
  print("=====match:${match?.group(0)}=========");
}
void foo4() {
  StringScanner scanner = StringScanner("toly 1994,hello!");
  while (!scanner.isDone) {
    if (scanner.scan(RegExp(r'\d+'))) {
      print('======Match:${scanner.lastMatch?.group(0)}=============');
      continue;
    }
    print("=====${scanner.string[scanner.position]}=======");
    scanner.position++;
  }
}
void foo5(){
  StringScanner scanner = StringScanner("toly 1994,hello!");
  while (!scanner.isDone) {
    if(scanner.scan(RegExp(r'\d+'))){
      print('======Match:${scanner.lastMatch?.group(0)}=============');
      continue;
    }
    if(scanner.scan(RegExp(r'o.'))){
      print('======Match:${scanner.lastMatch?.group(0)}=============');
      continue;
    }
    print("=====${scanner.string[scanner.position]}=======");
    scanner.position++;
  }
}