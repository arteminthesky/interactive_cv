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
        color: const Color(0xff2c2c2c),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            // TODO: refactor this trick
            cornerRadius: kIphone14ScreenBorderRadius + 6,
            cornerSmoothing: 0.5,
          ),
        ),
        shadows: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 60,
          )
        ],
      ),
      child: ClipSmoothRect(
        radius: SmoothBorderRadius(
          // TODO: refactor this trick
        cornerRadius: kIphone14ScreenBorderRadius + 6,
          cornerSmoothing: 0.5,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: kIphone14ScreenBorderRadius + 6,
                        // TODO: refactor this trick
                        cornerSmoothing: 0.5,
                      ),
                    ),
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              child: Transform.rotate(
                angle: -pi / 4,
                child: ClipRect(
                  child: Container(
                    width: kIphone14ScreenSize.width * 2.5,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0.3),
                          Colors.transparent,
                          Colors.white.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RepaintBoundary(
                key: const ValueKey('screen_repaint_boundary'),
                child: ClipSmoothRect(
                  clipBehavior: Clip.antiAlias,
                  radius: SmoothBorderRadius(
                    cornerRadius: kIphone14ScreenBorderRadius,
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
                          screenBorderRadius: kIphone14ScreenBorderRadius,
                        ),
                      ),
                      const Positioned(
                        bottom: 7,
                        child: _GestureIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 15,
              child: _Notch(),
            ),
          ],
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
