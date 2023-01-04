import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexp/09/02/components/custom/button/async_button.dart';

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
    contentCtrl.text = widget.model?.content ?? '';
    titleCtrl.text = widget.model?.title ?? '';
  }

  @override
  void dispose() {
    contentCtrl.dispose();
    titleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.model == null ? "添加记录" : "修改记录";
    return Column(
      children: <Widget>[
        _buildDialogBar(title),
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

  Future<void> _onConform(BuildContext context) async {
    if (!checkAllow()) return;
    RecordBloc bloc = context.read<RecordBloc>();
    if (widget.model == null) {
      // 说明是添加
      await bloc.insert(titleCtrl.text, contentCtrl.text,);
    } else {
      // 说明是修改
      await bloc.update(
        widget.model!.copyWith(
          title: titleCtrl.text,
          content: contentCtrl.text,
        ),
      );
    }
    Navigator.of(context).pop();
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(msg),
        ),
      );
    }
    return msg.isEmpty;
  }

  Widget _buildDialogBar(String title) {
    ButtonStyle style = ElevatedButton.styleFrom(
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: const StadiumBorder(),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.close, size: 20)),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          AsyncButton(
            conformText: '确定',
            task: _onConform,
            style: style,
          ),
        ],
      ),
    );
  }

}
