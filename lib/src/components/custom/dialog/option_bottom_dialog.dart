import 'dart:async';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2021/1/11
/// contact me by email 1981462002@qq.com
/// 说明:

class AsyncItem {
  final FutureOr Function()? task;
  final String info;
 

  AsyncItem({this.task,required this.info});
}

class PickPhotoDialog extends StatelessWidget {
  final List<AsyncItem> tasks;
  final String? message;

  const PickPhotoDialog({super.key, required this.tasks,this.message});

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(message!=null)
                _buildMessage(context,message),
              ...tasks
                  .asMap()
                  .keys
                  .map((index) => buildItem(index, context))
                  .toList(),
              Container(
                color: Color(0xffE5E3E4).withOpacity(0.3),
                height: 10,
              ),
              buildCancel(context)
            ],
          )),
    );
  }

  Widget buildCancel(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Ink(
          width: MediaQuery.of(context).size.width,
          height: 50,
          color: Colors.white,
          child: Center(
              child: Text(
            '取消',
            style: TextStyle(fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  Widget buildItem(int index, BuildContext context) {
    return Material(
      child: InkWell(
          onTap: () async {
            Navigator.of(context).pop();
            if (tasks[index].task != null) await tasks[index].task?.call();
          },
          child: Ink(
            height: 52,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: index != tasks.length - 1
                        ? BorderSide(
                            color: Colors.grey.withOpacity(0.2), width: 0.5)
                        : BorderSide.none)),
            child: Center(
              child: Text(
                tasks[index].info,
                style: TextStyle(fontSize: 17,color: Colors.black,),
              ),
            ),
          )),
    );
  }

  Widget _buildMessage(BuildContext context,String? message) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        maxHeight: 52
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(
              bottom:
                   BorderSide(
                  color: Colors.grey.withOpacity(0.2), width: 0.5))),
      child: Text('${message}', style: TextStyle(fontSize: 15,color: Colors.grey)),

    );
  }
}
