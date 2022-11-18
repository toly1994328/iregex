import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(blurRadius: 1, color: Colors.blue)]),
      child: CircleAvatar(
        radius: 15,
        backgroundImage: AssetImage('assets/images/icon_head.webp'),
      ),
    );
  }
}