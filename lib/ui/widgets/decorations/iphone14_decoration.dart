part of decorations;

class IPhone14Decoration extends StatelessWidget {
  const IPhone14Decoration({
    Key? key,
    required this.appBuilder,
  }) : super(key: key);

  final AppBuilder appBuilder;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      position: DecorationPosition.background,
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 56,
            cornerSmoothing: 0.5,
          ),
          side: const BorderSide(
            color: Color(0xff2c2c2c),
            width: 4,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 50,
                cornerSmoothing: 0.5,
              ),
              side: const BorderSide(
                color: Colors.black,
                width: 8,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
          ),
          child: RepaintBoundary(
            key: const ValueKey('screen_repaint_boundary'),
            child: ClipSmoothRect(
              radius: SmoothBorderRadius(
                cornerRadius: 50,
                cornerSmoothing: 0.5,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.fromSize(
                    size: kIphone14ScreenSize,
                    child: appBuilder(
                      context,
                      kIphone14ScreenSize,
                      kIphone14SafeArea,
                    ),
                  ),
                  const Positioned(
                    top: 5,
                    child: _Notch(),
                  ),
                  const Positioned(
                    bottom: 5,
                    child: _GestureIndicator(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Notch extends StatelessWidget {
  const _Notch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: Colors.black,
      ),
      child: SizedBox.fromSize(
        size: kIphone14NotchSize,
      ),
    );
  }
}

class _GestureIndicator extends StatelessWidget {
  const _GestureIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: Colors.black,
      ),
      child: SizedBox.fromSize(
        size: kGestureIndicatorSize,
      ),
    );
  }
}
