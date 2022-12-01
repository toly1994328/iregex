import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexp/src/blocs/blocs.dart';

import '../../models/models.dart';
import '../link_regex/link_regex_tab.dart';
import '../record/record_panel.dart';
import 'pure_bottom_bar.dart';
import 'standard_search_bar.dart';
import 'package:regexp/src/views/home/content_text_panel.dart';
class PhoneHomePage extends StatelessWidget {
  const PhoneHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PureBottomBar(),
      appBar: PhoneHomeTopBar(),
      drawer: RecordDrawer(),
      body: PageView(
        children: [
          ContentTextPanel()
        ],
      ),
    );
  }
}

class PhoneHomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const PhoneHomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
      ),
      bottom: LinkRegexTab(),
      titleSpacing: 0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0,
      title:PhoneRegexInput() ,
      actions: [          IconButton(
          splashRadius: 20,
          onPressed: (){}, icon: Icon(Icons.more_vert_sharp))],
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight+26);
  }
}




class PhoneRegexInput extends StatefulWidget {
  const PhoneRegexInput({super.key});

  @override
  State<PhoneRegexInput> createState() => _PhoneRegexInputState();
}

class _PhoneRegexInputState extends State<PhoneRegexInput> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    LinkRegexState regex = context.read<LinkRegexBloc>().state;
    _listenLinkRegexChange(context, regex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LinkRegexBloc, LinkRegexState>(
      listener: _listenLinkRegexChange,
      child: SizedBox(
          height: 35,
          child: Material(
            color: Colors.transparent,
            child: TextField(
              controller: _ctrl,
              autofocus: false,
              enabled: true,
              cursorColor: Colors.blue,
              maxLines: 1,
              onChanged: (str) => _doSearch(context, str),
              onSubmitted: (str) {
                //提交后,收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF3F6F9),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius:
                    BorderRadius.all(Radius.circular(35 / 2)),
                  ),
                  hintText: "输入正则表达式...",
                  hintStyle: TextStyle(fontSize: 14)),
            ),
          )),
    );
  }

  _doSearch(BuildContext context, String str) {}

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


