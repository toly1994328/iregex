import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/impl/db/model/record.dart';
import '../../../views/record/bloc/record_bloc.dart';
import '../../../repository/impl/db/model/link_regex.dart';
import '../../../views/link_regex/bloc/link_regex_bloc.dart';

import '../../../components/custom/dialog/custom_dialog_bar.dart';
import '../../../components/custom/input/custom_input_panel.dart';
import '../../../components/custom/input/custom_label_input.dart';
//
// import '../../components/custom/dialog/custom_dialog_bar.dart';
// import '../../components/custom/input/custom_input_panel.dart';
// import '../../components/custom/input/custom_label_input.dart';
// import '../../repository/impl/db/model/record.dart';
// import '../record/bloc/record_bloc.dart';

/// create by 张风捷特烈 on 2020-04-23
/// contact me by email 1981462002@qq.com
/// 说明:

class EditRecordPanel extends StatefulWidget {
  final LinkRegex? model;

  const EditRecordPanel({Key? key, this.model}) : super(key: key);

  @override
  _EditRecordPanelState createState() => _EditRecordPanelState();
}

class _EditRecordPanelState extends State<EditRecordPanel> {

  final TextEditingController contentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // contentCtrl.text = widget.model?.content ?? '';
    // titleCtrl.text = widget.model?.title ?? '';
  }

  @override
  void dispose() {
    contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomDialogBar(
          title: widget.model == null ? "添加关联正则" : "修改记录",
          conformText: "确定",
          onConform: _onConform,
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15),
        //   child: CustomIconInput(
        //     controller: titleCtrl,
        //     hintText: "输入记录名称...",
        //     icon: Icons.drive_file_rename_outline,
        //   ),
        // ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: CustomInputPanel(
              controller: contentCtrl,
              hintText: '输入正则表达式...',
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> _onConform() async {
    if (!checkAllow()) return false;
    LinkRegexBloc bloc = context.read<LinkRegexBloc>();
    Record? record = context.read<RecordBloc>().state.activeRecord;
    if(record == null) return false;
    int result = -1;
    if (widget.model == null) {
      // 说明是添加
      result = await bloc.repository.insert(LinkRegex.i(
         regex: contentCtrl.text,
          recordId: record.id
      ));

    } else {
      // 说明是修改
      // operation = LoadType.edit;
      // result = await bloc.repository.update(
      //   widget.model!.copyWith(
      //     title: titleCtrl.text,
      //     content: contentCtrl.text,
      //   ),
      // );
    }
    if (result > 0) {
      bloc.loadLinkRegex(recordId: record.id);
    } else {
      return false;
    }
    return true;
  }

  bool checkAllow() {
    String msg = '';
    if (contentCtrl.text.isEmpty) {
      msg = "内容不能为空!";
    }
    if (msg.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(msg),
        ),
      );
    }
    return msg.isEmpty;
  }
}
