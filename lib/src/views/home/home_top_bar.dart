import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexp/src/app/iconfont/toly_icon.dart';
import 'package:regexp/src/blocs/blocs.dart';
import 'package:regexp/src/components/feedback_widget.dart';

import 'package:regexp/src/models/models.dart';
import '../../components/logo.dart';
import '../../models/link_regex/link_regex.dart';

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
    Color color = Theme.of(context).backgroundColor;
    return Container(
      height: 50,
      color: color,
      child: Row(children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 8.0, bottom: 8, right: 10),
          child: FeedbackWidget(
            onPressed: onSelect,
            child: const Icon(TolyIcon.icon_file, size: 22),
          ),
        ),
        const ThemeSwitchButton(),
        Expanded(
            child: RegexInput(
          onRegexChange: onRegexChange,
        )),
        const SaveRegexButton(),
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

class SaveRegexButton extends StatelessWidget {
  const SaveRegexButton({super.key});
  @override
  Widget build(BuildContext context) {
    bool emptyRegex = context.select<MatchBloc, bool>(
          (value) => value.state.pattern.isEmpty,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
      child: GestureDetector(
        onTap: emptyRegex?null:()=>_onSaveLinkRegex(context),
        child:   Icon(
          TolyIcon.save,
          size: 24,
          color: emptyRegex?Colors.grey: const Color(0xff59A869),
        ),
      ),
    );
  }

  void _onSaveLinkRegex(BuildContext context) async{
    String regex = context.read<MatchBloc>().state.pattern;
    Record? record = context.read<RecordBloc>().state.activeRecord;
    LinkRegexBloc linkRegexBloc = context.read<LinkRegexBloc>();
    if (record != null) {
      await linkRegexBloc.repository.insert(LinkRegex.i(
        recordId: record.id,
        regex: regex,
      ));
      linkRegexBloc.loadLinkRegex(recordId: record.id);
    }
  }
}


class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeMode mode = context.select<AppConfigBloc, ThemeMode>(
      (value) => value.state.themeMode,
    );
    Widget icon = mode == ThemeMode.dark
        ? const Icon(TolyIcon.wb_sunny, size: 22)
        : const Icon(TolyIcon.dark, size: 22);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20, top: 8.0, bottom: 8),
      child: GestureDetector(
        onTap: () => _switchTheme(context),
        child: icon,
      ),
    );
  }

  void _switchTheme(BuildContext context) {
    context.read<AppConfigBloc>().switchThemeMode();
  }
}

class RegexInput extends StatefulWidget {
  final ValueChanged<String> onRegexChange;

  const RegexInput({super.key, required this.onRegexChange});

  @override
  State<RegexInput> createState() => _RegexInputState();
}

class _RegexInputState extends State<RegexInput> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    LinkRegexState regex = context.read<LinkRegexBloc>().state;
    _listenLinkRegexChange(context, regex);
  }

  @override
  Widget build(BuildContext context) {
    Color? color = Theme.of(context).inputDecorationTheme.fillColor;
    return BlocListener<LinkRegexBloc, LinkRegexState>(
      listener: _listenLinkRegexChange,
      child: SizedBox(
        height: 28,
        child: TextField(
          controller: _ctrl,
          onChanged: widget.onRegexChange,
          style: const TextStyle(fontSize: 12),
          maxLines: 1,
          decoration: InputDecoration(
              filled: true,
              hoverColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              fillColor: color,
              prefixIcon: const Icon(Icons.edit, size: 18),
              border: const UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: "输入正则表达式...",
              hintStyle: const TextStyle(fontSize: 12)),
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
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}
