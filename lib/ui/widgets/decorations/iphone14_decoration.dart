part of decorations;

class IPhone14Decoration extends StatelessWidget {
  const IPhone14Decoration({
    Key? key,
    required this.appBuilder,
  }) : super(key: key);

  final AppBuilder appBuilder;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 50,
                cornerSmoothing: 0.5,
              ),
              side: const BorderSide(
                color: Colors.black,
                width: 6,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
          ),
          child: ClipSmoothRect(
            radius: SmoothBorderRadius(
              cornerRadius: 50,
              cornerSmoothing: 0.5,
            ),
            child: SizedBox.fromSize(
              size: kIphone14ScreenSize,
              child: appBuilder(
                context,
                kIphone14ScreenSize,
                kIphone14SafeArea,
              ),
            ),
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
