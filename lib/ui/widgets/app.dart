part of widgets;

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key, required this.app}) : super(key: key);

  final Application app;

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final LayerLink _iconLayerLink = LayerLink();
  OverlayEntry? _menuOverlayEntry;

  @override
  Widget build(BuildContext context) {
    var appIconWidget = AppIcon(
      color: widget.app.info.icon.backgroundColor ?? Colors.white,
      gradient: widget.app.info.icon.gradient,
      child: widget.app.buildIcon(context),
    );

    return GestureDetector(
      onLongPress: () {
        _createOverlay(appIconWidget);
        assert(_menuOverlayEntry != null);

        Overlay.of(context).insert(_menuOverlayEntry!);
      },
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          widget.app.open(context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: widget.app.info.name,
              child: CompositedTransformTarget(
                link: _iconLayerLink,
                child: appIconWidget,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                widget.app.info.name,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createOverlay(Widget appIcon) {
    _menuOverlayEntry = OverlayEntry(
      builder: (context) {
        return OptionsOverlay(
          options: widget.app.options,
          appIcon: appIcon,
          onClose: () {
            _menuOverlayEntry?.remove();
          },
          layerLink: _iconLayerLink,
        );
      },
    );
  }
}
