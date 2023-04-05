part of base;

class AppIcon extends StatelessWidget {
  const AppIcon({
    Key? key,
    required this.child,
    this.color = Colors.white,
    this.gradient,
  })  :super(key: key);

  final Widget child;
  final Gradient? gradient;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: ClipSmoothRect(
        radius: const SmoothBorderRadius.all(
          SmoothRadius(
            cornerRadius: 15,
            cornerSmoothing: 0.5,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            // Gradient has priority
            color: gradient == null ? (color ?? Colors.white) : null,
            gradient: gradient,
          ),
          child: child,
        ),
      ),
    );
  }
}
