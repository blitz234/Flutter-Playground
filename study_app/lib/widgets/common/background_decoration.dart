import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_colors.dart';

class BackGround extends StatelessWidget {
  const BackGround({super.key, required this.child, this.showGradient = false});
  final Widget child;
  final bool showGradient;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
              color: showGradient ? null : Theme.of(context).primaryColor,
              gradient: showGradient ? mainGradient(context) : null),
          child: CustomPaint(painter: BackgroundPainter()),
        )),
        Positioned(child: SafeArea(child: child))
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);
    // above line is same as
    // Paint paint1 = Paint();
    //  paint1.color = Colors.white;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(0, size.height * 0.4);
    path.close();

    canvas.drawPath(path, paint);

    final path2 = Path();
    path2.moveTo(size.width, 0);
    path2.lineTo(size.width * 0.8, 0);
    path2.lineTo(size.width * 0.2, size.height);
    path2.lineTo(size.width, size.height);
    path2.close();

    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
