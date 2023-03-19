part of base;

const double _kHeight = 304.0;
const double _kEdgeDragHeight = 20.0;
const double _kMinFlingVelocity = 365.0;
const Duration _kBaseSettleDuration = Duration(milliseconds: 246);

typedef TopDrawerCallback = void Function(bool isOpened);

class _TopDrawerControllerScope extends InheritedWidget {
  const _TopDrawerControllerScope({
    required this.controller,
    required super.child,
  });

  final TopDrawerController controller;

  @override
  bool updateShouldNotify(_TopDrawerControllerScope old) {
    return controller != old.controller;
  }
}

class TopDrawerController extends StatefulWidget {
  const TopDrawerController({
    GlobalKey? key,
    required this.child,
    this.isDrawerOpen = false,
    this.drawerCallback,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrimColor,
    this.edgeDragHeight,
    this.enableOpenDragGesture = true,
  }) : super(key: key);

  final Widget child;

  final TopDrawerCallback? drawerCallback;
  final DragStartBehavior dragStartBehavior;
  final Color? scrimColor;
  final bool enableOpenDragGesture;
  final double? edgeDragHeight;
  final bool isDrawerOpen;

  static TopDrawerController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_TopDrawerControllerScope>()
        ?.controller;
  }

  static TopDrawerController of(BuildContext context) {
    final TopDrawerController? controller = maybeOf(context);
    return controller!;
  }

  @override
  TopDrawerControllerState createState() => TopDrawerControllerState();
}

class TopDrawerControllerState extends State<TopDrawerController>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: widget.isDrawerOpen ? 1.0 : 0.0,
      duration: _kBaseSettleDuration,
      vsync: this,
    );
    _controller
      ..addListener(_animationChanged)
      ..addStatusListener(_animationStatusChanged);
  }

  @override
  void dispose() {
    _historyEntry?.remove();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrimColorTween = _buildScrimColorTween();
  }

  @override
  void didUpdateWidget(TopDrawerController oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrimColor != oldWidget.scrimColor) {
      _scrimColorTween = _buildScrimColorTween();
    }
    if (widget.isDrawerOpen != oldWidget.isDrawerOpen) {
      switch (_controller.status) {
        case AnimationStatus.completed:
        case AnimationStatus.dismissed:
          _controller.value = widget.isDrawerOpen ? 1.0 : 0.0;
          break;
        case AnimationStatus.forward:
        case AnimationStatus.reverse:
          break;
      }
    }
  }

  void _animationChanged() {
    setState(() {
      // The animation controller's state is our build state, and it changed already.
    });
  }

  LocalHistoryEntry? _historyEntry;
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  void _ensureHistoryEntry() {
    if (_historyEntry == null) {
      final ModalRoute<dynamic>? route = ModalRoute.of(context);
      if (route != null) {
        _historyEntry = LocalHistoryEntry(
            onRemove: _handleHistoryEntryRemoved,
            impliesAppBarDismissal: false);
        route.addLocalHistoryEntry(_historyEntry!);
        FocusScope.of(context).setFirstFocus(_focusScopeNode);
      }
    }
  }

  void _animationStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.forward:
        _ensureHistoryEntry();
        break;
      case AnimationStatus.reverse:
        _historyEntry?.remove();
        _historyEntry = null;
        break;
      case AnimationStatus.dismissed:
        break;
      case AnimationStatus.completed:
        break;
    }
  }

  void _handleHistoryEntryRemoved() {
    _historyEntry = null;
    close();
  }

  late AnimationController _controller;

  void _handleDragDown(DragDownDetails details) {
    _controller.stop();
    _ensureHistoryEntry();
  }

  void _handleDragCancel() {
    if (_controller.isDismissed || _controller.isAnimating) {
      return;
    }
    if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  final GlobalKey _drawerKey = GlobalKey();

  double get _height {
    final RenderBox? box =
        _drawerKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      return box.size.height;
    }
    return _kHeight; // drawer not being shown currently
  }

  bool _previouslyOpened = false;

  void _move(DragUpdateDetails details) {
    double delta = details.primaryDelta! / _height;

    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.value -= delta;
        break;
      case TextDirection.ltr:
        _controller.value += delta;
        break;
    }

    final bool opened = _controller.value > 0.5;
    if (opened != _previouslyOpened && widget.drawerCallback != null) {
      widget.drawerCallback!(opened);
    }
    _previouslyOpened = opened;
  }

  void _settle(DragEndDetails details) {
    if (_controller.isDismissed) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dy.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dy / _height;

      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _controller.fling(velocity: -visualVelocity);
          widget.drawerCallback?.call(visualVelocity < 0.0);
          break;
        case TextDirection.ltr:
          _controller.fling(velocity: visualVelocity);
          widget.drawerCallback?.call(visualVelocity > 0.0);
          break;
      }
    } else if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  void open() {
    _controller.fling();
    widget.drawerCallback?.call(true);
  }

  void close() {
    _controller.fling(velocity: -1.0);
    widget.drawerCallback?.call(false);
  }

  late ColorTween _scrimColorTween;
  final GlobalKey _gestureDetectorKey = GlobalKey();

  ColorTween _buildScrimColorTween() {
    return ColorTween(
      begin: Colors.transparent,
      end: widget.scrimColor ??
          DrawerTheme.of(context).scrimColor ??
          Colors.black54,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;

    double? dragAreaHeight = widget.edgeDragHeight;
    if (widget.edgeDragHeight == null) {
      dragAreaHeight = _kEdgeDragHeight + padding.top;
    }

    if (_controller.status == AnimationStatus.dismissed) {
      if (widget.enableOpenDragGesture) {
        return Align(
          alignment: Alignment.topCenter,
          child: GestureDetector(
            key: _gestureDetectorKey,
            supportedDevices: const {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            },
            onVerticalDragUpdate: _move,
            onVerticalDragEnd: _settle,
            behavior: HitTestBehavior.translucent,
            excludeFromSemantics: true,
            dragStartBehavior: widget.dragStartBehavior,
            child: Container(height: dragAreaHeight),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    } else {
      final Widget child = _TopDrawerControllerScope(
        controller: widget,
        child: RepaintBoundary(
          child: Stack(
            children: <Widget>[
              BlockSemantics(
                child: GestureDetector(
                  supportedDevices: const {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch,
                  },
                  onTap: close,
                  child: Container(
                    color: _scrimColorTween.evaluate(_controller),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: _controller.value,
                  child: RepaintBoundary(
                    child: FocusScope(
                      key: _drawerKey,
                      node: _focusScopeNode,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      return GestureDetector(
        key: _gestureDetectorKey,
        onVerticalDragDown: _handleDragDown,
        onVerticalDragUpdate: _move,
        onVerticalDragEnd: _settle,
        onVerticalDragCancel: _handleDragCancel,
        excludeFromSemantics: true,
        dragStartBehavior: widget.dragStartBehavior,
        child: child,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildDrawer(context);
  }
}
