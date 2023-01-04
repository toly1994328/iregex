import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Toast {

  static toast( String msg,
      {duration = const Duration(milliseconds: 1000), Color? color}) {
    showToast(
      msg,
      backgroundColor: color,
      position: ToastPosition.bottom,
      duration: duration,
      textPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    );
  }

  static error(String msg,
      {duration = const Duration(milliseconds: 600)}) {
    toast(msg, color: Colors.redAccent);
  }

  static success( String msg,
      {duration = const Duration(milliseconds: 600)}) {
    toast( msg, color: Colors.green);
  }

  static warning( String msg,
      {duration = const Duration(milliseconds: 600)}) {
    toast(msg, color: Colors.orange);
  }
}
