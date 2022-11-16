import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ui.Image? logoImage;
  ui.Image? logo2Image;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    loadImage();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void loadImage() async {
    ByteData data1 = await rootBundle.load('assets/images/img.png');
    ByteData data2 = await rootBundle.load('assets/images/logo1.png');
    logoImage = await decodeImageFromList(data1.buffer.asUint8List());
    logo2Image = await decodeImageFromList(data2.buffer.asUint8List());
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _controller.reset();
                _controller.forward();
              },
              child: CustomPaint(
                painter: DunDunPainter(logoImage, logo2Image, _controller),
                size: const Size(200, 200),
              ),
            ),
            SizedBox(width: 20,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlutterLogo(size: 100,),
                SizedBox(height: 80,),

                Text('Draw By 张风捷特烈')
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DunDunPainter extends CustomPainter {
  final ui.Image? logoImage;
  final ui.Image? logo2Image;
  final Animation<double> repaint;

  DunDunPainter(this.logoImage, this.logo2Image, this.repaint)
      : super(repaint: repaint);

  final Paint helpPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.blue;
  final Paint pathPaint = Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    // print(size);
    // canvas.drawCircle(Offset.zero, 10, Paint());
    // canvas.drawRect(Offset.zero & size, helpPaint);

    Path dundunPath = Path();

    canvas.translate(30, 80);
    helpPaint.color = Colors.red;
    Path axisPath = Path()
      ..relativeLineTo(0, 50)
      ..moveTo(0, 0)
      ..relativeLineTo(0, -50)
      ..moveTo(0, 0)
      ..relativeLineTo(50, 0)
      ..moveTo(0, 0)
      ..relativeLineTo(-50, 0);
    // canvas.drawPath(axisPath, helpPaint);

    pathPaint.style = PaintingStyle.fill;

    Path leftHandPath = buildLeftHandPath();
    pathPaint.color = Colors.black;
    canvas.drawPath(leftHandPath, pathPaint);

    Path erPath = buildErPath();
    canvas.drawPath(erPath, pathPaint);

    // paintErPoints(canvas);
    // canvas.drawPath(leftHandPath, pathPaint..strokeWidth=1..color=Colors.cyanAccent);
    // paintHandsHelpPoints(canvas);

    Path rightHandPath = buildRightHandPath();
    pathPaint.color = Colors.black;
    canvas.drawPath(rightHandPath, pathPaint);
    // canvas.drawPath(rightHandPath, pathPaint..strokeWidth=1..color=Colors.cyanAccent);
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Color(0xffF1F4F7);

    Path bodyPath = buildBodyPath();
    // paintBodyPoints(canvas);
    // F1F4F7

    canvas.drawPath(bodyPath, pathPaint);
    // paintRightHandsHelpPoints(canvas);

    canvas.save();
    Path eyePath = Path();
    Matrix4 m = Matrix4.translationValues(46, -12, 0)
        .multiplied(Matrix4.rotationZ(45 / 180 * pi));
    eyePath
        .addOval(Rect.fromCenter(center: Offset(0, 0), width: 32, height: 49));
    eyePath = eyePath.transform(m.storage);
    pathPaint.color = Colors.black;
    canvas.drawPath(eyePath, pathPaint);
    canvas.restore();

    Path nosePath = Path();
    nosePath.moveTo(
      79,
      -0,
    );
    nosePath.relativeLineTo(
      12,
      -12,
    );
    nosePath.relativeLineTo(
      -24,
      0,
    );
    nosePath.close();
    Path clipCirclePath = Path();
    clipCirclePath.addOval(Rect.fromCenter(
        center: Offset(
          79,
          -10,
        ),
        width: 12,
        height: 12));
    // canvas.drawPath(
    //     clipCirclePath,
    //     pathPaint
    //       ..strokeWidth = 1
    //       ..color = Colors.cyanAccent);
    // nosePath.quadraticBezierTo(78, 15, 90, 0);
    // nosePath.quadraticBezierTo(78, 6, 65, 0,);
    nosePath = Path.combine(PathOperation.intersect, nosePath, clipCirclePath);
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.black;
    canvas.drawPath(nosePath, pathPaint);

    Path smaliPath = Path();
    smaliPath.moveTo(
      65,
      -0,
    );

    smaliPath.quadraticBezierTo(78, 15, 90, 0);
    smaliPath.quadraticBezierTo(
      78,
      6,
      65,
      0,
    );
    pathPaint.color = Colors.red;
    canvas.drawPath(smaliPath, pathPaint);
    canvas.drawPath(
        smaliPath,
        pathPaint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.black);

    Paint colorfulPaint = Paint()..style = PaintingStyle.stroke;
    List<Color> colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    final List<double> pos =
        List.generate(colors.length, (index) => index / colors.length);
    colorfulPaint.shader = ui.Gradient.sweep(
        Offset(
          60,
          -5,
        ),
        colors,
        pos,
        TileMode.clamp,
        0,
        2 * pi);
    colorfulPaint.maskFilter = MaskFilter.blur(BlurStyle.solid, 2);

    Path colorfulPath = Path();
    colorfulPath.addOval(Rect.fromCenter(
        center: Offset(
          72,
          -5,
        ),
        width: 120,
        height: 110));
    colorfulPath.addOval(Rect.fromCenter(
        center: Offset(
          72,
          -5,
        ),
        width: 110,
        height: 100));
    colorfulPath.addOval(Rect.fromCenter(
        center: Offset(
          72,
          -5,
        ),
        width: 115,
        height: 110));
    colorfulPath.addOval(Rect.fromCenter(
        center: Offset(
          72,
          -5,
        ),
        width: 120,
        height: 105));
    colorfulPath.addOval(Rect.fromCenter(
        center: Offset(
          72,
          -5,
        ),
        width: 115,
        height: 105));
    colorfulPath.addOval(Rect.fromCenter(
        center: Offset(
          72,
          -5,
        ),
        width: 117,
        height: 103));
    canvas.drawPath(colorfulPath, colorfulPaint);
    // helpPaint.strokeWidth = 4;
    // canvas.drawPoints(
    //     ui.PointMode.points,
    //     [
    //       Offset(79, -2,),
    //       Offset(90, 0),
    //       Offset(78, 15),
    //     ],
    //     helpPaint);

    canvas.save();
    Path eyePath2 = Path();
    Matrix4 m2 = Matrix4.translationValues(105, -12, 0)
        .multiplied(Matrix4.rotationZ(-40 / 180 * pi));
    eyePath2
        .addOval(Rect.fromCenter(center: Offset(0, 0), width: 29, height: 48));
    eyePath2 = eyePath2.transform(m2.storage);
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.black;
    canvas.drawPath(eyePath2, pathPaint);

    // canvas.drawPath(
    //     eyePath2,
    //     pathPaint
    //       ..strokeWidth = 1
    //       ..color = Colors.cyanAccent);
    canvas.restore();
    Path rightEyePath = Path();
    rightEyePath.addOval(
        Rect.fromCenter(center: Offset(98, -14), width: 17, height: 17));
    pathPaint.style = PaintingStyle.stroke;
    pathPaint.color = Colors.white;
    canvas.drawPath(rightEyePath, pathPaint..strokeWidth = 2);

    Path rightEyePath2 = Path();
    rightEyePath2
        .addOval(Rect.fromCenter(center: Offset(98, -14), width: 7, height: 7));
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.white.withOpacity(0.4);
    canvas.drawPath(rightEyePath2, pathPaint);

    Path rightEyePath3 = Path();
    rightEyePath3
        .addOval(Rect.fromCenter(center: Offset(98, -19), width: 4, height: 4));
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.white;
    canvas.drawPath(rightEyePath3, pathPaint);

    Path leftEyePath = Path();
    leftEyePath.addOval(
        Rect.fromCenter(center: Offset(50, -13), width: 18, height: 18));
    pathPaint.style = PaintingStyle.stroke;
    pathPaint.color = Colors.white;
    canvas.drawPath(leftEyePath, pathPaint..strokeWidth = 2);

    Path leftEyePath2 = Path();
    leftEyePath2
        .addOval(Rect.fromCenter(center: Offset(50, -13), width: 7, height: 7));
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.white.withOpacity(0.4);
    canvas.drawPath(leftEyePath2, pathPaint);

    Path leftEyePath3 = Path();
    leftEyePath3
        .addOval(Rect.fromCenter(center: Offset(51, -19), width: 4, height: 4));
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.white;
    canvas.drawPath(leftEyePath3, pathPaint);

    // canvas.drawPath(rightHandPath, pathPaint..strokeWidth=1..color=Colors.cyanAccent);

    Path leftFootPath = buildFootPath();
    pathPaint.style = PaintingStyle.fill;
    pathPaint.color = Colors.black;
    canvas.drawPath(leftFootPath, pathPaint);
    // paintLeftFoodHelpPoints(canvas);

    //

    helpPaint.strokeWidth = 4;

    //爱心
    List<Offset> arr = [];
    int len = 50;
    double a = 1;
    for (int i = 0; i < len; i++) {
      double step = (i / len) * (pi * 2); //递增的θ
      Offset offset = Offset(
        a * (11 * pow(sin(step), 3)).toDouble(),
        -a *
            (9 * cos(step) -
                5 * cos(2 * step) -
                2 * cos(3 * step) -
                cos(4 * step)),
      );
      arr.add(offset);
    }
    Path starPath = Path();
    for (int i = 0; i < len; i++) {
      starPath.lineTo(arr[i].dx, arr[i].dy);
    }
    pathPaint..color = Colors.red;
    starPath = starPath.shift(Offset(152, -20));
    canvas.drawPath(starPath, pathPaint);

    if (logoImage != null && logo2Image != null) {
      Rect src = Rect.fromLTWH(
          0, 0, logoImage!.width.toDouble(), logoImage!.height.toDouble());
      Rect dst = Rect.fromLTWH(0, 0, size.width, size.height);
      Paint paint = Paint()..color = Colors.black.withOpacity(0.5);
      // canvas.drawImageRect(logoImage!, src, dst, paint);

      Rect src2 = Rect.fromLTWH(
          0, 0, logo2Image!.width.toDouble(), logo2Image!.height.toDouble());
      Rect dst2 = Rect.fromLTWH(50, 55, 899 / 27, 1066 / 27);

      canvas.drawImageRect(logo2Image!, src2, dst2, Paint());
    }

    dundunPath.addPath(bodyPath, Offset.zero);
    dundunPath.addPath(leftHandPath, Offset.zero);
    dundunPath.addPath(rightHandPath, Offset.zero);
    dundunPath.addPath(leftFootPath, Offset.zero);
    dundunPath.addPath(erPath, Offset.zero);
    dundunPath.addPath(eyePath, Offset.zero);
    dundunPath.addPath(eyePath2, Offset.zero);
    dundunPath.addPath(leftEyePath, Offset.zero);
    dundunPath.addPath(leftEyePath2, Offset.zero);
    dundunPath.addPath(leftEyePath3, Offset.zero);
    dundunPath.addPath(rightEyePath, Offset.zero);
    dundunPath.addPath(rightEyePath2, Offset.zero);
    dundunPath.addPath(rightEyePath3, Offset.zero);
    dundunPath.addPath(nosePath, Offset.zero);
    dundunPath.addPath(starPath, Offset.zero);
    dundunPath.addPath(colorfulPath, Offset.zero);
    dundunPath.addPath(smaliPath, Offset.zero);

    // pathPaint
    //   ..strokeWidth = 1
    //   ..color = Colors.cyanAccent;
    // PathMetrics pms = dundunPath.computeMetrics();
    // pms.forEach((pm) {
    //   canvas.drawPath(pm.extractPath(0, pm.length * repaint.value), pathPaint);
    // });

    // canvas.drawPath(
    //     dundunPath,
    //     pathPaint
    //       ..strokeWidth = 1..style=PaintingStyle.stroke
    //       ..color = Colors.cyanAccent);
    Path dundunOutLine = Path.combine(
        PathOperation.union,
        Path.combine(
            PathOperation.union,
            Path.combine(
                PathOperation.union,
                Path.combine(PathOperation.union, bodyPath, leftFootPath),
                rightHandPath),
            leftHandPath),
        erPath);
    Paint outLinePainter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 3;
    outLinePainter.maskFilter = MaskFilter.blur(BlurStyle.outer, 4);
    canvas.drawPath(dundunOutLine, outLinePainter);

    Path p2 = Path()..addOval(Rect.fromCenter(
        center: Offset(
          72,
          -5,
        ),
        width: 126,
        height: 116));

    outLinePainter.maskFilter = MaskFilter.blur(BlurStyle.outer, 4);
    canvas.drawPath(
        p2,
        outLinePainter..color=Colors.black..strokeWidth=2);
  }

  Path buildBodyPath() {
    Path path = Path();
    path.quadraticBezierTo(10, -75, 75, -75);
    path.quadraticBezierTo(135, -70, 138, 0);
    path.quadraticBezierTo(130, 90, 65, 98);
    path.quadraticBezierTo(-5, 85, 0, 0);
    return path;
  }

  Path buildLeftHandPath() {
    Path path = Path();
    path.quadraticBezierTo(
      -17,
      14,
      -28,
      40,
    );
    path.quadraticBezierTo(-32, 58, -15, 62);
    path.quadraticBezierTo(10, 60, 0, 0);
    return path;
  }

  Path buildRightHandPath() {
    Path path = Path();
    path.moveTo(135, -20);
    path.quadraticBezierTo(140, -48, 165, -35);
    path.quadraticBezierTo(180, -17, 135, 22);
    path.quadraticBezierTo(125, 17, 135, -20);
    return path;
  }

  Path buildFootPath() {
    Path path = Path();
    path.moveTo(18, 78);
    path.quadraticBezierTo(18, 100, 22, 115);
    path.quadraticBezierTo(60, 125, 55, 98);
    path.quadraticBezierTo(35, 80, 18, 78);

    Path right = path
        .transform(Matrix4.diagonal3Values(-1, 1, 1).storage)
        .shift(const Offset(128, 0));

    return Path.combine(PathOperation.union, path, right);
  }

  Path buildErPath() {
    Path path = Path();
    path.moveTo(13, -40);
    path.quadraticBezierTo(8, -95, 40, -68);
    path.quadraticBezierTo(40, -55, 13, -40);

    Path right = path
        .transform(Matrix4.diagonal3Values(-1, 1, 1).storage)
        .shift(const Offset(138, -5));

    return Path.combine(PathOperation.union, path, right);
  }

  void paintBodyPoints(ui.Canvas canvas) {
    helpPaint.strokeWidth = 4;
    canvas.drawPoints(
        ui.PointMode.points,
        [
          Offset(10, -68),
          Offset(75, -75),

          Offset(135, -70),
          Offset(138, 0),

          Offset(130, 90),
          Offset(65, 98),

          // Offset(55,98),
          // Offset(18,78),

          Offset(-5, 85),
          Offset(0, 0),
        ],
        helpPaint);
  }

  void paintErPoints(ui.Canvas canvas) {
    helpPaint.strokeWidth = 4;
    canvas.drawPoints(
        ui.PointMode.points,
        [
          Offset(
            13,
            -40,
          ),
          Offset(
            40,
            -68,
          ),
          Offset(40, -55),
          Offset(
            8,
            -95,
          ),
          // Offset(18, 78),
          // Offset(22, 115),
          // Offset(55, 98),
          // Offset(
          //   40,
          //   80,
          // ),
        ],
        helpPaint);
  }

  void paintHandsHelpPoints(ui.Canvas canvas) {
    helpPaint.strokeWidth = 4;
    canvas.drawPoints(
        ui.PointMode.points,
        [
          Offset(-0, 0),
          Offset(-17, 14),
          Offset(-28, 40),
          Offset(-32, 58),
          Offset(-15, 62),
          Offset(
            8,
            60,
          ),
          Offset(-0, 0),
        ],
        helpPaint);
  }

  void paintRightHandsHelpPoints(ui.Canvas canvas) {
    helpPaint.strokeWidth = 4;
    canvas.drawPoints(
        ui.PointMode.points,
        [
          // Offset(10,-68),
          // Offset(75,-75),
          //
          Offset(140, -48),
          Offset(165, -35),

          Offset(180, -17),
          Offset(135, 22),

          Offset(125, 17),
          Offset(135, -20),

          // Offset(55,98),
          // Offset(18,78),
        ],
        helpPaint);
  }

  void paintLeftFoodHelpPoints(ui.Canvas canvas) {
    helpPaint.strokeWidth = 4;
    canvas.drawPoints(
        ui.PointMode.points,
        [
          Offset(
            18,
            100,
          ),
          Offset(60, 125),
          Offset(18, 78),
          Offset(22, 115),
          Offset(55, 98),
          Offset(
            40,
            80,
          ),
        ],
        helpPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
