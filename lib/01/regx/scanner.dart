import 'package:string_scanner/string_scanner.dart';

main(){
  String src = '这是一段测试代码，我要测试测试，看能不能测试通过。';

  StringScanner scanner = StringScanner(src);

  int loopPosition = scanner.position;
  while (!scanner.isDone) {
    if(scanner.scan('这是')){
      print(scanner.lastMatch);
    }
    print(scanner.position);

    if (loopPosition == scanner.position) {
      return false;
    }
    loopPosition = scanner.position;
  }
  // scanner.
}