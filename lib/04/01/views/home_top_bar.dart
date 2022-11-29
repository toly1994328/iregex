import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:regexp/src/app/iconfont/toly_icon.dart';

import '../components/logo.dart';

class HomeTopBar extends StatelessWidget {
  final ValueChanged<String> onRegexChange;
  final ValueChanged<File> onFileSelect;

  const HomeTopBar({
    Key? key,
    required this.onRegexChange,
    required this.onFileSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: const Color(0xffF2F2F2),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: GestureDetector(
            onTap: onSelect,
            child: const Icon(TolyIcon.icon_file, size: 22),
          ),
        ),
        Expanded(child: _buildRegexInput()),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Logo(),
        ),
      ]),
    );
  }

  void onSelect() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String? path = result.files.single.path;
      if (path != null) {
        onFileSelect(File(path));
      }
    }
  }

  Widget _buildRegexInput() => SizedBox(
        height: 28,
        child: TextField(
          onChanged: onRegexChange,
          style: const TextStyle(fontSize: 12),
          maxLines: 1,
          decoration: const InputDecoration(
              filled: true,
              hoverColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.edit, size: 18),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: "输入正则表达式...",
              hintStyle: TextStyle(fontSize: 12)),
        ),
      );
}
