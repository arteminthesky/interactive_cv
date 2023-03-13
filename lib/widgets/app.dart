part of widgets;

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key, required this.app}) : super(key: key);

  final App app;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: DecoratedBox(
              decoration: const ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius.all(
                    SmoothRadius(cornerRadius: 15, cornerSmoothing: 0.5),
                  ),
                ),
                color: Colors.white,
              ),
              child: _AppIconSelector(
                app: app,
              ),
            ),
          ),
          Text(
            app.name,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _AppIconSelector extends StatelessWidget {
  const _AppIconSelector({
    Key? key,
    required this.app,
  }) : super(key: key);

  final App app;

  @override
  Widget build(BuildContext context) {
    switch (app.name) {
      case 'Calendar':
        return const CalendarAppIcon();
      default:
        return _AppIcon(
          app: app,
        );
    }
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon({
    Key? key,
    required this.app,
  }) : super(key: key);

  final App app;

  @override
  Widget build(BuildContext context) {
    if (app.icon == '') return const Offstage();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image(
        image: AssetImage(app.icon),
        fit: BoxFit.cover,
      ),
    );
  }
}
