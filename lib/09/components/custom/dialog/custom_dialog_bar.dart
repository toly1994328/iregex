import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef AsyncTask = Future<bool> Function();

class CustomDialogBar extends StatefulWidget {
  final String conformText;
  final String title;
  final AsyncTask? onConform;

  const CustomDialogBar({
    super.key,
    this.conformText = "确定",
    this.title = "添加记录",
    this.onConform,
  });

  @override
  State<CustomDialogBar> createState() => _CustomDialogBarState();
}

class _CustomDialogBarState extends State<CustomDialogBar> {
  @override
  Widget build(BuildContext context) {
    ButtonStyle style = ElevatedButton.styleFrom(
        elevation: 0, padding: EdgeInsets.zero, shape: const StadiumBorder());

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
          // ElevatedButton(onPressed: (){}, child: Text("取消")),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
              onPressed: _loading ? null : _doTask,
              style: style,
              child: _loading
                  ? const CupertinoActivityIndicator(radius: 8)
                  : Text(
                      widget.conformText,
                      style: const TextStyle(fontSize: 12),
                    )),
        ],
      ),
    );
  }

  bool _loading = false;

  void _doTask() async {
    if (widget.onConform == null) return;
    _loading = true;
    setState(() {});
    bool success = await widget.onConform!();
    if (success) {
      Navigator.of(context).pop();
    }
    _loading = false;
    setState(() {});
  }
}
