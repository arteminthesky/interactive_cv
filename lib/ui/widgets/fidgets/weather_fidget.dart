part of fidgets;

class WeatherFidget extends StatelessWidget {
  const WeatherFidget({
    Key? key,
    this.aspectRatio = 2,
  }) : super(key: key);

  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return FidgetPanel(
      aspectRatio: aspectRatio,
      child: ColoredBox(
        color: Colors.white24,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: const [
              Text('Weather'),
              Text('Good'),
            ],
          ),
        ),
      ),
    );
  }
}
