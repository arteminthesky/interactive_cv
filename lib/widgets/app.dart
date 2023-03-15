part of widgets;

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key, required this.app}) : super(key: key);

  final Application app;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        app.open(context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIcon(
            color: app.appIcon.backgroundColor ?? Colors.white,
            gradient: app.appIcon.gradient,
            child: _AppIconSelector(
              app: app.appIcon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              app.appIcon.name,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
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
        return _DefaultIcon(
          app: app,
        );
    }
  }
}

class _DefaultIcon extends StatelessWidget {
  const _DefaultIcon({
    Key? key,
    required this.app,
  }) : super(key: key);

  final App app;

  @override
  Widget build(BuildContext context) {
    if (app.icon == '') return const Offstage();
    return Padding(
      padding: EdgeInsets.all(app.iconPadding?.toDouble() ?? 0.0),
      child: Image(
        image: AssetImage(app.icon),
        fit: BoxFit.cover,
        color: app.imageColor,
      ),
    );
  }
}
