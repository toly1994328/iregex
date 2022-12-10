import 'package:flutter/material.dart';

class Highlight {
  final TextStyle commentStyle; // 注释高亮样式
  final TextStyle stringStyle; // 字符串高亮样式
  final TextStyle metaStyle; // 注解高亮样式
  final TextStyle numberStyle; // 数字高亮样式
  final TextStyle keywordsStyle; // 关键字高亮样式
  final TextStyle typeStyle; // 类型名高亮样式
  final TextStyle classNameStyle; // 类定义名高亮样式
  final TextStyle noneStyle; // 普通文字高亮样式
  final Color backgroundColor; // 背景色

  const Highlight({
    required this.commentStyle,
    required this.stringStyle,
    required this.metaStyle,
    required this.numberStyle,
    required this.keywordsStyle,
    required this.typeStyle,
    required this.classNameStyle,
    required this.noneStyle,
    required this.backgroundColor,
  });

  static const Highlight magula = Highlight(
      commentStyle: TextStyle(color: Color(0xFF777777), fontSize: 14),
      stringStyle: TextStyle(color: Color(0xFF005500), fontSize: 14),
      metaStyle: TextStyle(color: Color(0xFF0000ee), fontSize: 14),
      numberStyle: TextStyle(color: Color(0xFF880000), fontSize: 14),
      keywordsStyle: TextStyle(color: Color(0xFF000080), fontSize: 14, fontWeight: FontWeight.w500),
      typeStyle: TextStyle(color: Color(0xFF000080), fontSize: 14, fontWeight: FontWeight.w500),
      classNameStyle: TextStyle(color: Color(0xFF000080), fontSize: 14, fontWeight: FontWeight.w500),
      noneStyle: TextStyle(fontSize: 14, color: Colors.black),
      backgroundColor: Color(0xfff4f4f4));

  static const Highlight agate = Highlight(
      commentStyle: TextStyle(color: Color(0xFF888888), fontSize: 14),
      stringStyle: TextStyle(color: Color(0xFFa2fca2), fontSize: 14),
      metaStyle: TextStyle(color: Color(0xFFfc9b9b), fontSize: 14),
      numberStyle: TextStyle(color: Color(0xFFfcc28c), fontSize: 14),
      keywordsStyle: TextStyle(color: Color(0xFFffffaa), fontSize: 14, fontWeight: FontWeight.w500),
      typeStyle: TextStyle(color: Color(0xFFfcc28c), fontSize: 14, fontWeight: FontWeight.w500),
      classNameStyle: TextStyle(color: Color(0xFFffffaa), fontSize: 14, fontWeight: FontWeight.w500),
      noneStyle: TextStyle(fontSize: 14, color: Colors.white),
      backgroundColor: Color(0xff333333));

  static const Highlight dracula = Highlight(
      commentStyle: TextStyle(color: Color(0xFF6272a4), fontSize: 14),
      stringStyle: TextStyle(color: Color(0xFFf1fa8c), fontSize: 14),
      metaStyle: TextStyle(color: Color(0xFFfc9b9b), fontSize: 14),
      numberStyle: TextStyle(color: Colors.white, fontSize: 14),
      keywordsStyle: TextStyle(color: Color(0xFF8be9fd), fontSize: 14),
      typeStyle: TextStyle(color: Colors.white, fontSize: 14),
      classNameStyle: TextStyle(color: Color(0xFFf1fa8c), fontSize: 14, fontWeight: FontWeight.w500),
      noneStyle: TextStyle(fontSize: 14, color: Colors.white),
      backgroundColor: Color(0xff282A36));

  static const Highlight tomorrow = Highlight(
      commentStyle: TextStyle(color: Color(0xFF8e908c), fontSize: 14,fontStyle: FontStyle.italic,),
      stringStyle: TextStyle(color: Color(0xFF718c00), fontSize: 14),
      metaStyle: TextStyle(color: Color(0xFFf5871f), fontSize: 14),
      numberStyle: TextStyle(color: Color(0xFFf5871f), fontSize: 14),
      keywordsStyle: TextStyle(color: Color(0xFF8959a8), fontSize: 14,),
      typeStyle: TextStyle(color:Color(0xFFf5871f), fontSize: 14),
      classNameStyle: TextStyle(color: Color(0xFF4271ae), fontSize: 14, fontWeight: FontWeight.w500),
      noneStyle: TextStyle(fontSize: 14, color: Color(0xff4d4d4c)),
      backgroundColor: Colors.white);
}