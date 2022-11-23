import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
void main() async{
  // String srcPath = '/Users/mac/Coder/files/markdown/toly-blog/掘金小册/Flutter 语言基础 - 梦始之地/03 学会说话 - 语句和量的定义.md';
  String srcPath = '/Users/mac/Coder/files/markdown/toly-blog/玩转正则表达式 (Flutter 全端实现)/5.添加切换测试文字功能.md';
  String distDirPath = '/Users/mac/Coder/files/photo/toly-blog-res';
  Dio dio = Dio();
  File file = File(srcPath);
  String content = file.readAsStringSync();
  RegExp exp = RegExp(r'!\[.*\]\((.*?)\)');
  Iterable<RegExpMatch> allMatches = exp.allMatches(content);
  List<String?> urls = [];
  for (RegExpMatch match in allMatches) {
    urls.add(match.group(1));
  }
  print(urls);

  String fileName = path.basenameWithoutExtension(srcPath);
  String parentDirName = path.basenameWithoutExtension(file.parent.path);
  Directory distDir = Directory(path.join(distDirPath,parentDirName,fileName));
  if(!distDir.existsSync()){
    distDir.createSync(recursive: true);
  }
  for (String? url in urls) {
    if(url==null) continue;
    String fileName = path.basename(url);
    String distPath = path.join(distDir.path,fileName);
    if(!url.startsWith("http")){
      File src = File(url);
      if(src.path == distPath) continue;
      src.copySync(distPath);
      src.deleteSync();
    }else{
      await downloadImage(dio,url,distPath);
    }
  }
  print("done copy image to ==${distDir.path}=====");

  String newContent = content.replaceAllMapped(exp, (match){
    String url = match.group(1)??'';
    String result = '';
    if(!url.startsWith("http")){
      String fileName = path.basename(url);
      result = '![](${path.join(distDir.path,fileName)})';
    }else{
      result = '![]($url)';
    }
    return result;
  });
  file.writeAsStringSync(newContent);
}

Future<void> downloadImage(Dio dio,String url,String path) async{
  await dio.download(url, path);
  print("=====已下载:$url===========");
  return;
}