
import 'dart:io';

void main()async{
  // await foo();
  print("方法信息: ");

  await foo2();

}

Future<void> foo()async{
  File file = File('/Users/mac/Coder/Projects/Flutter/regexp/lib/test/class_paser/padding.dart');
  String content = await file.readAsString();
  String regex = r'(\w+\s+)?\w+(\s+)?\(((\s+)?(\w+\?)?(\s+)?\w+(\s+)?,?)*(\s+)?([\{\[]((\s+)?(\w+\?(\s+))?(\w+(\s+)?)?(\w+(\s+)?)(=(\s+)?[\w\.\(\), ]+)?,?(\s+)?)+[\}\]])*\)(\s+)?[=\{]';
  Iterable<RegExpMatch> allMatches = RegExp(regex).allMatches(content);

  for (RegExpMatch match in allMatches) {
    print("方法信息: ${match.group(0)}");
  }
}

Future<void> foo2()async{
  File file = File('/Users/mac/Coder/Projects/Flutter/regexp/lib/test/class_paser/padding.dart');
  // File file = File('/Users/mac/Coder/Projects/Flutter/regexp/lib/18/01/parser/regex_parser.dart');

  String content = await file.readAsString();
  print("content: $content");

  String regex = r'((?<returnType>\w+)\s+)?(?<funName>\w+)(\s+)?\((?<funParmas>((\s+)?(\w+\?)?(\s+)?\w+(\s+)?,?)*(\s+)?([\{\[]((\s+)?(\w+\?(\s+))?(\w+(\s+)?)?(\w+(\s+)?)(=(\s+)?[\w\.\(\), ]+)?,?(\s+)?)+[\}\]])*)\)(\s+)?[=\{]';

  Iterable<RegExpMatch> allMatches = RegExp(regex).allMatches(content);
  print("allMatches:${allMatches.length}");

  for (RegExpMatch match in allMatches) {
    String returnType = match.namedGroup('returnType')?? "";
    String funName = match.namedGroup('funName')?? "";
    String funParmas = match.namedGroup('funParmas')?? "";
    print("函数名:${funName}\n返回值:${returnType}\n函数参数列表:${funParmas}\n\n");
  }
}

void move(int x, int y) {

}

class Position {
  void move(int x, int y) {

  }
}

class Hero {
  final String name;
  final int atk;

  const Hero(this.name, this.atk);

  void move({required int x, required int y}) {}

  //\(((((?<pType>\w+) )?(?<pValue>\w+)(,?))+)\)
  //(?<backType>void| \w+)?( +)(?<funName>\w+)(\()
// (?<backType>void| \w+)? 返回值
// ( +) 空格
// (?<funName>\w+) 函数名

// \(((\w+ \w+(,?))+)\) 普通入参
//
  foo4(offset) {}

  foo1(Offset offset) {}

  foo2(
    Offset offset,
  ) {}

  foo3(Offset offset, int a) {}

  foo({required int x, required int y, int z = 0}) {}

  void moveTo(Offset offset) {
    if (Offset() != null) {}
  }

  @override
  String toString() {
    return 'Hero{name: $name, atk: $atk}';
  }
}

class Offset{

}