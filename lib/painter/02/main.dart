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
    ByteData data = await rootBundle.load('assets/images/img.png');
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
    // print(size);
    // canvas.drawCircle(Offset.zero, 10, Paint());
    canvas.drawRect(Offset.zero & size, helpPaint);
    if (logoImage != null) {
      Rect src = Rect.fromLTWH(
          0, 0, logoImage!.width.toDouble(), logoImage!.height.toDouble());
      Rect dst = Rect.fromLTWH(0, 0, size.width, size.height);
      // canvas.drawImageRect(logoImage!, src, dst, Paint());
      // canvas.drawImageRect(logoImage!, src, dst, Paint()..color=Colors.black.withOpacity(0.1));
    }
    // canvas.translate(-100, 10);
    // helpPaint.color=Colors.red;
    // canvas.drawLine(Offset(size.width/2,0), Offset(size.width/2,size.height), helpPaint);
    // canvas.drawLine(Offset(0,size.height/2), Offset(size.width,size.height/2), helpPaint);
    //
    // helpPaint.color=Colors.deepOrange;
    // helpPaint.strokeWidth=3;
    // helpPaint.strokeCap=StrokeCap.round;
    // canvas.translate(100, 100);
    //
    //
    // Path helpPath = Path();
    // helpPath.lineTo(200, -48);
    // // canvas.drawPath(helpPath, pathPaint);
    //
    // Path path = Path();
    // path.moveTo(12, 14);
    // path.lineTo(0, 0);
    // path.quadraticBezierTo(53,-38,100,-39,);
    // path.cubicTo(145,-40,190,-26,200,-48,);
    // path.quadraticBezierTo(195,-20,178,-11);
    // path.quadraticBezierTo(165,-8,125,-15);
    // path.quadraticBezierTo(70,-29,12, 14);

    // path.cubicTo(45,-40,120,10,12, 14);
    // path.cubicTo(70,-50,100,-39,200,-48);
    // canvas.drawPath(path, pathPaint..strokeWidth=1..color=Color(0xffADDFFC)..style=PaintingStyle.fill);

    canvas.drawPoints(
        ui.PointMode.points,
        [
          // Offset(200,-48),
          // Offset(100,-39),
          // Offset(50,-38),
          // Offset(190,-29),
          // Offset(160,-25),
          // Offset(90,-18),
          // Offset(180,-12),
          // Offset(200,-30),
          // Offset(45,-40,),
          // Offset(125,-15),
          // Offset(165,-11,),
          // Offset(80,-28,),
        ],
        helpPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
