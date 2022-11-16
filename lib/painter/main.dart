import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ui.Image? logoImage;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void loadImage() async {
    ByteData data = await rootBundle.load('assets/images/logo.png');
    logoImage = await decodeImageFromList(data.buffer.asUint8List());
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: DunDunPainter(logoImage),
          size: const Size(200, 200),
        ),
      ),
    );
  }
}

class DunDunPainter extends CustomPainter {
  final ui.Image? logoImage;

  DunDunPainter(this.logoImage);

  final Paint helpPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.blue;
  final Paint pathPaint = Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, helpPaint);
    if (logoImage != null) {
      Rect src = Rect.fromLTWH(
        0,
        0,
        logoImage!.width.toDouble(),
        logoImage!.height.toDouble(),
      );
      Rect dst = Rect.fromLTWH(
        0,
        0,
        size.width,
        size.height,
      );
      canvas.drawImageRect(
          logoImage!, src, dst, Paint());
      // canvas.drawImageRect(logoImage!, src, dst, Paint()..color=Colors.black.withOpacity(0.1));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
