main() {
  String src = '鲁迅创作了《狂人日记》，是中国现代文学史第一篇白话文小说。'
      '《诗经》是中国古代诗歌开端，最早的一部诗歌总集。';
  RegExp exp = RegExp(r'《(.*?)》');
  Iterable<RegExpMatch> allMatches = exp.allMatches(src);

  for (RegExpMatch match in allMatches) {
    print("match:${match.group(1)}");
  }
  foo2();
}

void foo2(){
  String src = """
  ##### 2.分组的用处

前面我们知道 `《.*?》` 可以匹配所有的书名号及中间的字符，那问题来了。如果我们想要获取书名，不想要 `《》` 怎么办？

![](https://gitee.com/toly1994/toly_blog_pic/raw/master/image-20220206124458587.png)

我们前面学过了位置匹配，可以通过 `(?<=《).*?(?=》)` 根据位置做到只匹配内容，效果如下：

![](https://gitee.com/toly1994/toly_blog_pic/raw/master/image-20220206124801290.png)

不过上面看着非常复杂，通过分组可以很好地实现这个需求，通过 `《(.*?)》` ，这样通过 `match.group(1)` 就可以获取到括号内正则的匹配结果：
  """;

  RegExp exp = RegExp(r'!\[.*\](\(.*?\))');
  Iterable<RegExpMatch> allMatches = exp.allMatches(src);

  for (RegExpMatch match in allMatches) {
    print("${match.group(1)}");
  }
}