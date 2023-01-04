import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/impl/db/model/record.dart';
import 'bloc/record_bloc.dart';

class DeleteMessagePanel extends StatelessWidget {
  final Record model;

  const DeleteMessagePanel({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: Colors.redAccent,
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: const StadiumBorder(),
    );
    Color? cancelTextColor = Theme.of(context).textTheme.displayMedium?.color;
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.warning_amber_rounded,color: Colors.orange,),
            const SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text("删除提示",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 15,),
                    child: Text("数据删除后将无法恢复，是否确认删除标题为 [${model.title}] 记录！",style: const TextStyle(fontSize: 14),),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      OutlinedButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          style: OutlinedButton.styleFrom(
                            // backgroundColor: Color(value),
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: const StadiumBorder(),
                          ),
                          child:  Text(
                            '取消',
                            style:  TextStyle(fontSize: 12,color: cancelTextColor),
                          )),
                      const SizedBox(width: 10,),
                      ElevatedButton(
                          onPressed: ()=>_doTask(context),
                          style: style,
                          child: const Text(
                            '删除',
                            style: TextStyle(fontSize: 12),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _doTask(BuildContext context) async{
    RecordBloc bloc = context.read<RecordBloc>();
    await bloc.deleteById(model.id);
    Navigator.of(context).pop();
  }
}
