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
            child: app.buildIcon(context),
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
