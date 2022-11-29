import 'package:flutter/material.dart';
import '../../models/record/record.dart';

class RecordItem extends StatelessWidget {
  final Record record;
  final bool active;
  final VoidCallback onTap;

  const RecordItem({Key? key, required this.record, this.active = false,required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          color: active
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.white,
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(record.title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              Text(
                record.content,
                maxLines: 2,
                style: const TextStyle(fontSize: 12, color: Color(0xffCECBCD)),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )),
    );
  }
}