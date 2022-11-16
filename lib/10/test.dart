
main(){
  String src = """
class A {}

abstract class B {}

abstract class D {}

class C extends A with D, E implements B {}

mixin E {}

mixin F {}
""";
  String reg = r'(^(?<ClassType>(abstract )?class|mixin) (?<ClassName>\w+)( extends )?(?<Father>\w+)?)|(?<Mixins>((?<=with).*(?=implements)))|(?<Implements>((?<=implements ).*(?= \{)))';

  RegExp exp = RegExp(reg,multiLine: true);
  List<RegExpMatch> allMatches = exp.allMatches(src).toList();

  for (var match in allMatches) {
    print("====类类型:${match.namedGroup("ClassType")}");
    print("====类名:${match.namedGroup("ClassName")}");
    print("====父类名:${match.namedGroup("Father")}");
    print("====混入类:${match.namedGroup("Mixins")}");
    print("====实现接口类:${match.namedGroup("Implements")}");

    // for (int i = 0; i <= match.groupCount; i++) {
    //   print("groupIndex:$i====match:${match.group(i)}");
    // }
  }
}