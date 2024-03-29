import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:regexp/src/blocs/blocs.dart';
import 'package:regexp/src/views/home/content_text_panel.dart';
import 'package:regexp/src/views/home/home_foot.dart';

import '../../models/models.dart';
import '../link_regex/link_regex_tab.dart';
import '../record/record_panel.dart';
import 'home_pop_icon.dart';
import 'phone_regex_input.dart';
import 'pure_bottom_bar.dart';

class PhoneHomePage extends StatelessWidget {
  const PhoneHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const PureBottomBar(),
      appBar: const PhoneHomeTopBar(),
      drawer: const RecordDrawer(),
      body: PageView(
        children: [
          Column(
            children: [
              const Expanded(child: ContentTextPanel()),
              const FootBar(),
            ],
          )
        ],
      ),
    );
  }
}

class PhoneHomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const PhoneHomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    Color? color = Theme.of(context).backgroundColor;

    return AppBar(
      bottom: const LinkRegexTab(),
      titleSpacing: 0,
      backgroundColor: color,
      // iconTheme: IconThemeData(color: iconColor),
      elevation: 0,
      title: const PhoneRegexInput(),
      actions: [
        HomePopIcon(
          onFileSelect: (f) => _onFileSelect(context, f),
        )
      ],
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight + 26);
  }

  void _onFileSelect(BuildContext context, File file) async {
    String content = file.readAsStringSync();
    if (content.length > 1000) {
      content = content.substring(0, 1000);
    }
    RecordBloc bloc = context.read<RecordBloc>();
    await bloc.repository.insert(Record.i(
      title: path.basenameWithoutExtension(file.path),
      content: content,
    ));
    bloc.loadRecord(operation: LoadType.add);
  }
}



