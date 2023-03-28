import 'package:flutter/material.dart';

enum StepType {
  begin,
  end,
  middle,
}

class StepWidget extends StatelessWidget {
  List<Widget> steps;

  StepWidget({Key? key, required this.steps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepRow(
          stepType: StepType.begin,
          child: steps.first,
        ),
        for (Widget step in steps.sublist(1, steps.length - 1))
          StepRow(
            stepType: StepType.middle,
            child: step,
          ),
        if (steps.first != steps.last)
          StepRow(
            stepType: StepType.end,
            child: steps.last,
          ),
      ],
    );
  }
}

class StepRow extends StatelessWidget {
  final StepType stepType;
  final Widget child;

  const StepRow({Key? key, required this.stepType, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StepColumnPainter(stepType, 40),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 40,
          ),
          Expanded(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

abstract class StepColumnPainter extends CustomPainter {
  factory StepColumnPainter(StepType stepType, double width) {
    switch (stepType) {
      case StepType.begin:
        return BeginStepColumnPainter(width);
      case StepType.end:
        return EndStepColumnPainter(width);
      default:
        return MiddleStepColumnPainter(width);
    }
  }

  StepColumnPainter._(this.width);

  double width;

  Paint linePaint = Paint()
    ..color = Colors.grey
    ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    Size stepRowAreaSize = Size(width, size.height);
    drawLine(canvas, stepRowAreaSize);
    drawStepIndicator(canvas, stepRowAreaSize);
  }

  void drawStepIndicator(Canvas canvas, Size size) {
    canvas.drawCircle(size.center(Offset.zero), 5, linePaint);
  }

  void drawLine(Canvas canvas, Size size);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BeginStepColumnPainter extends StepColumnPainter {
  BeginStepColumnPainter(double width) : super._(width);

  final Paint _indicatorColor = Paint()..color = Colors.lightGreenAccent;

  @override
  void drawStepIndicator(Canvas canvas, Size size) {
    super.drawStepIndicator(canvas, size);
    canvas.drawCircle(size.center(Offset.zero), 3, _indicatorColor);
  }

  @override
  void drawLine(Canvas canvas, Size size) {
    canvas.drawLine(
        size.center(Offset.zero), size.bottomCenter(Offset.zero), linePaint);
  }
}

class MiddleStepColumnPainter extends StepColumnPainter {
  MiddleStepColumnPainter(double width) : super._(width);

  @override
  void drawLine(Canvas canvas, Size size) {
    canvas.drawLine(
        size.topCenter(Offset.zero), size.bottomCenter(Offset.zero), linePaint);
  }
}

class EndStepColumnPainter extends StepColumnPainter {
  EndStepColumnPainter(double width) : super._(width);

  @override
  void drawLine(Canvas canvas, Size size) {
    canvas.drawLine(
        size.topCenter(Offset.zero), size.center(Offset.zero), linePaint);
  }
}
