import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexp/src/app/iconfont/toly_icon.dart';

import '../components/logo.dart';
import '../repository/impl/db/model/link_regex.dart';
import 'link_regex/bloc/link_regex_bloc.dart';
import 'link_regex/bloc/link_regex_state.dart';

class HomeTopBar extends StatelessWidget {
  final ValueChanged<String> onRegexChange;
  final ValueChanged<File> onFileSelect;
  final VoidCallback onSaveLinkRegx;

  const HomeTopBar({
    Key? key,
    required this.onRegexChange,
    required this.onSaveLinkRegx,
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
        Expanded(
            child: RegexInput(
          onRegexChange: onRegexChange,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
          child: GestureDetector(
            onTap: onSaveLinkRegx,
            child: const Icon(
              TolyIcon.save,
              size: 24,
              color: Color(0xff59A869),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 20, left: 10),
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

}

class RegexInput extends StatefulWidget {
  final ValueChanged<String> onRegexChange;

  const RegexInput({super.key,required this.onRegexChange});

  @override
  State<RegexInput> createState() => _RegexInputState();
}

class _RegexInputState extends State<RegexInput> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LinkRegexBloc,LinkRegexState>(
      listener: _listenLinkRegexChange,
      child: SizedBox(
        height: 28,
        child: TextField(
          controller: _ctrl,
          onChanged: widget.onRegexChange,
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
      ),
    );
  }

  void _listenLinkRegexChange(BuildContext context, LinkRegexState state) {
    if (state is LoadedLinkRegexState) {
      LinkRegex? regex = state.activeRegex;
      if (regex != null) {
        if (regex.id == -1) {
          _ctrl.text = '';
        } else {
          _ctrl.text = regex.regex;
        }
      }
      widget.onRegexChange(_ctrl.text);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}
