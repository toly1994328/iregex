import 'package:flutter/material.dart';

import 'edit_record_panel.dart';

class RecordTopBar extends StatelessWidget {
  const RecordTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: EdgeInsets.only(left: 8,right: 4),
      alignment: Alignment.centerLeft,
      color: Color(0xffF3F3F3),
      child: Row(
        children: [
          Text('选择记录',style: TextStyle(fontSize: 11),),
          Spacer(),
          GestureDetector(
              onTap: ()=>showAddDialog(context),
              child: Icon(Icons.add,size: 16,color: Color(0xff7E7E7E),))
        ],
      ),
    );
  }

  showAddDialog(BuildContext context) {
    showDialog(context: context,
        barrierDismissible:false,
        builder: (_)=>Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5),
      child: Dialog(

          backgroundColor: Color(0xffF2F2F2),
          child: EditRecordPanel()),
    ));
  }
}
