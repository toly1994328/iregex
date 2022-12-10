import 'dart:collection';

main() {

  String src = '''
/** 
** create by 张风捷特烈 on 2022-12-10
** contact me by email 1981462002@qq.com
**/

const String _kCounty = 'China';

/// 代码高亮测试案例
class Hello {
  final String name; //名称
  final String county; //国家
  final int age; //年龄
  final double height; //身高

  Hello({
    this.name = "张风捷特烈",
    this.age = 28,
    this.height = 1.80, 
    this.county = _kCounty
  });

  @override
  String toString() {
    int a = 0xff9999;
    int b = 1.0f;
    int c = 1.0e5;
    String prefix = r'\\d+'; 
    String label = """toly1994
    张风捷特烈
    """;
    return 'Hello{name: \$name}';
  }
}
  ''';
  RegExp exp = RegExp(r'^',multiLine: true);

  List<RegExpMatch> allMatches = exp.allMatches(src).toList();
  int index = 0;
  for (var match in allMatches) {
    index++;
    print("==index:$index==match:${match.start}===${match.end}=");
  }
}

