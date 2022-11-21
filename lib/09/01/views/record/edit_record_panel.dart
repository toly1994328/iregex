import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/custom/dialog/custom_dialog_bar.dart';
import '../../components/custom/input/custom_input_panel.dart';
import '../../components/custom/input/custom_label_input.dart';
import '../../repository/impl/db/model/record.dart';
import '../record/bloc/record_bloc.dart';

/// create by 张风捷特烈 on 2020-04-23
/// contact me by email 1981462002@qq.com
/// 说明:

class EditRecordPanel extends StatefulWidget {
  final Record? model;

  const EditRecordPanel({Key? key, this.model}) : super(key: key);

  @override
  _EditRecordPanelState createState() => _EditRecordPanelState();
}

class _EditRecordPanelState extends State<EditRecordPanel> {

  final TextEditingController contentCtrl = TextEditingController();
  final TextEditingController titleCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    contentCtrl.text = widget.model?.title ?? '';
    titleCtrl.text = widget.model?.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomDialogBar(
          title: "添加记录",
          conformText: "确定",
          onConform: _onConform,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomIconInput(
            controller: titleCtrl,
            hintText: "输入记录名称...",
            icon: Icons.drive_file_rename_outline,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: CustomInputPanel(
              controller: contentCtrl,
              hintText: '输入记录内容...',
            ),
          ),
        ),
      ],
    );
  }

  void _onConform() async {
    if (!checkAllow()) return;
    RecordBloc bloc = context.read<RecordBloc>();
    if (widget.model == null) {
      // 说明是添加
      int count = await bloc.repository
          .insert(Record.i(title: titleCtrl.text, content: contentCtrl.text));
      print(count);
      if (count > 0) {
        bloc.loadRecord(loading: false);
        Navigator.of(context).pop();
      }
    }
  }

  bool checkAllow() {
    String msg = '';
    if (titleCtrl.text.isEmpty) {
      msg = "标题不能为空!";
    }
    if (contentCtrl.text.isEmpty) {
      msg = "内容不能为空!";
    }
    if (msg.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).errorColor, content: Text(msg)));
    }
    return msg.isEmpty;
  }
}
