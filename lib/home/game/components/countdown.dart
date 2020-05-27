import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main_screen.dart';

class CountDownTimer extends StatefulWidget {
  final VoidCallback onTimeFinished;

  const CountDownTimer({Key key, this.onTimeFinished}) : super(key: key);

  @override
  _CountDownTimerState createState() =>
      _CountDownTimerState(this.onTimeFinished);
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;
  final VoidCallback onTimeFinished;

  _CountDownTimerState(this.onTimeFinished);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );
    controller.value = 30;
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(0xffdbe2ef),
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                    lastOnTimeFinished: onTimeFinished,
                                    animationController: controller,
                                    animation: controller,
                                    backgroundColor: Colors.white,
                                    color: themeData.indicatorColor,
                                  )),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        timerString,
                                        style: TextStyle(
                                            fontSize: 80.0,
                                            color: Colors.white,
                                        shadows: [Shadow(
                                          color: Colors.grey.withOpacity(0.50),
                                          blurRadius: 20,
                                          offset: Offset(
                                              1, 2),
                                        )]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.lastOnTimeFinished,
    this.animationController,
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;
  final AnimationController animationController;
  final VoidCallback lastOnTimeFinished;

  @override
  void addListener(listener) {
    if (animation.value == 0) {
      animationController.dispose();
      lastOnTimeFinished();
    }
    super.addListener(listener);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (0 + animation.value) * 2 * 3.1415;
    canvas.drawArc(Offset.zero & size, 3.1415 * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    if (animation.value == 0) {
      return false;
    } else {
      return animation.value != old.animation.value ||
          color != old.color ||
          backgroundColor != old.backgroundColor;
    }
  }
}
