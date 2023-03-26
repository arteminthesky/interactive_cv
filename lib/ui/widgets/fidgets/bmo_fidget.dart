part of fidgets;

class BmoFidget extends StatelessWidget {
  const BmoFidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidgetPanel(
      aspectRatio: 2 / 3,
      radius: 25,
      blurred: false,
      child: CustomPaint(
        painter: BmoPainter(),
      ),
    );
  }
}

class BmoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var widgetWidth = size.width;

    var screenSize = Size(widgetWidth, widgetWidth / 1.5);

    _drawBackground(canvas, size);
    _drawScreen(canvas, screenSize);

    var controlsSize = Size(widgetWidth, size.height - screenSize.height);
    canvas.translate(0, screenSize.height);
    _drawControls(canvas, controlsSize);
  }

  void _drawBackground(Canvas canvas, Size size) {
    canvas.drawColor(const Color(0xff6ab8a0), BlendMode.src);
  }

  void _drawScreen(Canvas canvas, Size size) {
    var screenRect = Rect.fromLTWH(0, 0, size.width, size.height);
    screenRect = screenRect.deflate(10);
    canvas.drawRRect(
      RRect.fromRectXY(screenRect, 20, 20),
      Paint()..color = const Color(0xffc6fdcb),
    );
    canvas.drawRRect(
      RRect.fromRectXY(screenRect, 20, 20),
      Paint()
        ..color = Colors.black
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );

    _drawEye(canvas, screenRect.center + const Offset(-40, -10));
    _drawEye(canvas, screenRect.center + const Offset(40, -10));
    _drawMouth(canvas, screenRect.center);
  }

  void _drawEye(Canvas canvas, Offset offset) {
    canvas.drawCircle(
      offset,
      10,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      offset + const Offset(3, 3),
      3,
      Paint()..color = Colors.white54,
    );
  }

  void _drawMouth(Canvas canvas, Offset center) {
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 40, height: 40),
      pi / 4,
      pi / 2,
      false,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawControls(Canvas canvas, Size size) {
    var romRect = const Offset(40, 10) & const Size(150, 30);
    canvas.drawRect(
      romRect,
      Paint()..color = const Color(0xff163628),
    );
    canvas.drawRect(
      romRect,
      Paint()
        ..color = Colors.black
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(BmoPainter oldDelegate) {
    return false;
  }
}
