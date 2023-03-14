part of widgets;

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key, required this.app}) : super(key: key);

  final App app;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppIcon(
          color: Colors.white,
          child: _AppIconSelector(
            app: app,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            app.name,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
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
    return Image(
      image: AssetImage(app.icon),
      fit: BoxFit.cover,
    );
  }
}
