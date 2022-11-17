void main(){
  String src = '这是一段测试代码，我要测试测试，看能不能测试通过。';
  String pattern = '测试';
  List<String> parts = src.split(pattern);
  print(parts);
  print(parts.length);
}

//  InlineSpan formSpan(String src, String pattern) {
//     List<TextSpan> span = [];
//     RegExp regExp = RegExp(pattern, caseSensitive: false);
//     src.splitMapJoin(regExp, onMatch: (Match match) {
//       span.add(TextSpan(text: match.group(0), style: lightTextStyle));
//       return '';
//     }, onNonMatch: (str) {
//       span.add(TextSpan(
//           text: str,
//           style: lightTextStyle.copyWith(color: const Color(0xff2F3032))));
//       return '';
//     });
//     return TextSpan(children: span);
//   }