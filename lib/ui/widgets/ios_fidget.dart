part of widgets;

class IosFidget extends StatelessWidget {
  const IosFidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipSmoothRect(
      radius: const SmoothBorderRadius.all(
        SmoothRadius(cornerRadius: 20, cornerSmoothing: 0.5),
      ),
      child: child,
    );
  }
}
