main() {
  String src = """
  @font-face {
  font-family: "iconfont"; /* Project id 3167918 */
  src: url('iconfont.woff2?t=1643782061442') format('woff2'),
       url('iconfont.woff?t=1643782061442') format('woff'),
       url('iconfont.ttf?t=1643782061442') format('truetype');
}

.iconfont {
  font-family: "iconfont" !important;
  font-size: 16px;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.icon-icon_text_switch:before {
  content: "\e60d";
}

.icon-icon_input:before {
  content: "\e693";
}

.icon-icon_text:before {
  content: "\e678";
}

.icon-icon_switch:before {
  content: "\e624";
}
  """;
  RegExp exp = RegExp(r'\.icon\-(.*?):.*\s.*"(.*?)"');
  List<RegExpMatch> allMatches = exp.allMatches(src).toList();
  for (var match in allMatches) {
    print("====提取结果 :${match.group(1)}:${match.group(2)}");
  }
}
