import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/indicator/refresh_indicator_icon.dart';
import '../../repository/impl/db/model/record.dart';
import '../../../app/iconfont/toly_icon.dart';
import 'bloc/record_bloc.dart';
import 'delete_record_panel.dart';
import 'edit_record_panel.dart';

class RecordTopBar extends StatelessWidget {
  const RecordTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.only(left: 8, right: 4),
      alignment: Alignment.centerLeft,
      color: const Color(0xffF3F3F3),
      child: Row(
        children: [
          const Text(
            '选择记录',
            style: TextStyle(fontSize: 11),
          ),
          const SizedBox(width: 4,),
          RefreshIndicatorIcon(
            wait: Duration(seconds: 1),
            onRefresh: ()=>_onRefresh(context),
          ),
          const Spacer(),
          Wrap(
            spacing: 4,
            children: [
              GestureDetector(
                onTap: () => showEditeDialog(context),
                child: const Icon(
                  TolyIcon.icon_edit,
                  size: 16,
                  color: Colors.blue,
                ),
              ),
              GestureDetector(
                onTap: () => showDeleteDialog(context),
                child: const Icon(TolyIcon.icon_delete,
                    size: 16, color: Colors.redAccent),
              ),

              GestureDetector(
                  onTap: () => showAddDialog(context),
                  child: const Icon(
                    Icons.add,
                    size: 16,
                    color: Color(0xff7E7E7E),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  void showAddDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 5),
              child: const Dialog(
                backgroundColor: Color(0xffF2F2F2),
                child: EditRecordPanel(),
              ),
            ));
  }

  void showEditeDialog(BuildContext context) {
    RecordBloc bloc = context.read<RecordBloc>();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 5),
          child:  Dialog(
            backgroundColor: const Color(0xffF2F2F2),
            child: EditRecordPanel(model: bloc.state.activeRecord,),
          ),
        ));
  }

  void showDeleteDialog(BuildContext context) {
    RecordBloc bloc = context.read<RecordBloc>();
    Record? record = bloc.state.activeRecord;
    if(record == null) return;
    showDialog(
        context: context,
        builder: (_) => Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 4),
          child:  Dialog(
            backgroundColor: const Color(0xffF2F2F2),
            child: DeleteRecordPanel(model: record,),
          ),
        ));
  }

  void refresh(BuildContext context) {
    RecordBloc bloc = context.read<RecordBloc>();
    bloc.loadRecord(operation: LoadType.refresh);
  }

  Future<void> _onRefresh(BuildContext context) async{
    RecordBloc bloc = context.read<RecordBloc>();
    bloc.loadRecord(operation: LoadType.refresh);
  }
}
