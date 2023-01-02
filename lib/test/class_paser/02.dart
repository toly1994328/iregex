import 'package:flutter/cupertino.dart';

void move(int x, int y, {int z = 100, e = const Offset(10, 10), c = 0}) {}

void foo() {}

foo8({required int x, y = 0}) {}

foo7({required int? x, y = 0, z = 4589, a = Alignment.center}) {}

 class A {
  int foo(x)=>4;

  void foo4(x) {}
}

void foo5(int? x) {
  if (Offset.zero == null) {}
}

void foo1(int x) {}

void foo2(
  int x,
) {}

void foo3(
  int x,
  int y,
  int z,
) {}


//命名方法参数列表匹配: (\{((\s+)?(\w+\?(\s+))?(\w+(\s+)?)?(\w+(\s+)?)(=(\s+)?[\w\.\(\), ]+)?,?(\s+)?)+\})
//普通方法参数列表匹配: \(((\s+)?(\w+\?)?(\s+)?\w+(\s+)?,?)*(\s+)?\)
//方法匹配： (\w+\s+)?\w+(\s+)?\(((\s+)?(\w+\?)?(\s+)?\w+(\s+)?,?)*(\s+)?([\{\[]((\s+)?(\w+\?(\s+))?(\w+(\s+)?)?(\w+(\s+)?)(=(\s+)?[\w\.\(\), ]+)?,?(\s+)?)+[\}\]])*\)(\s+)?[=\{]
