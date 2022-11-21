import 'package:flutter/material.dart';

class CustomDialogBar extends StatelessWidget {
  final String conformText;
  final String title;
  final VoidCallback? onConform;

  const CustomDialogBar({
    super.key,
    this.conformText = "确定",
    this.title = "添加记录",
    this.onConform,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.close, size: 20)),
          ),
          // ElevatedButton(onPressed: (){}, child: Text("取消")),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
              onPressed: onConform,
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: const StadiumBorder()),
              child: Text(
                conformText,
                style: const TextStyle(fontSize: 12),
              )),

        ],
      ),
    );
  }
}
