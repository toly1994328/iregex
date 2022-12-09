/*
* create by 张风捷特烈 on 2022-12-10
* contact me by email 1981462002@qq.com
*/

const String _kCounty = 'China';
//(?<=((class )|(enum( {1}))|(mixin )))(\w)*
enum   Word { a }

mixin Liveable {}

/// 代码高亮测试案例
class Hello {
  final String name; //言语
  final String county; //国家
  final int age; //年龄
  final double height; //年龄

  Hello(
      {this.name = "张风捷特烈",
      this.age = 26,
      this.height = 1.80,
      this.county = _kCounty});

  @override
  String toString() {
    int a1 = 0xff9999;
    // int b = 1.0f;
    // int c = 1.0e5;
    String prefix = r'\d+';
    String label = """toly1994""";
    return 'Hello{name: $name}';
  }
}
