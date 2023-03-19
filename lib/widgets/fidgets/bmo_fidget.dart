part of fidgets;

class BmoFidget extends StatelessWidget {
  const BmoFidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidgetPanel(
      aspectRatio: 2/3,
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
    canvas.drawColor(Colors.greenAccent, BlendMode.src);
  }

  void _drawScreen(Canvas canvas, Size size) {
    var screenRect = Rect.fromLTWH(0, 0, size.width, size.height);
    screenRect = screenRect.deflate(10);
    canvas.drawRRect(
      RRect.fromRectXY(screenRect, 20, 20),
      Paint()..color = Colors.green,
    );
  }

  void _drawControls(Canvas canvas, Size size) {

  }

  @override
  bool shouldRepaint(BmoPainter oldDelegate) {
    return false;
  }
}
