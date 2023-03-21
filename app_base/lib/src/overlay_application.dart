import 'dart:ui';

import 'package:app_base/app_base.dart';
import 'package:flutter/widgets.dart';

abstract class OverlayApplication extends Application {
  OverlayApplication();

  OverlayEntry? _overlayEntry;

  final GlobalKey<_AppTransitionState> _appTransitionKey = GlobalKey();

  Widget _buildApp(BuildContext context) {
    return _Closable(
      onClose: _overlayEntry!.remove,
      child: _AppTransition(
        key: _appTransitionKey,
        builder: buildApp,
      ),
    );
  }

  Widget buildApp(BuildContext context);

  OverlayEntry _createOverlayEntry(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return OverlayEntry(
      builder: _wrapWithMediaQuery(mediaQuery),
    );
  }

  WidgetBuilder _wrapWithMediaQuery(MediaQueryData mediaQueryData) {
    return (context) {
      return MediaQuery(
        data: mediaQueryData,
        child: _buildApp(context),
      );
    };
  }

  void close(BuildContext context) {
    var state = context.findAncestorStateOfType<_AppTransitionState>()!;

    state.close().then((_) => _overlayEntry!.remove());
  }

  @override
  Future<void> open(BuildContext context, {String? deepLink}) {
    _overlayEntry = _createOverlayEntry(context);

    Overlay.of(context).insert(_overlayEntry!);
    return Future.value();
  }
}

class _AppTransition extends StatefulWidget {
  const _AppTransition({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;

  @override
  State<_AppTransition> createState() => _AppTransitionState();
}

class _AppTransitionState extends State<_AppTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _transitionController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  @override
  void initState() {
    super.initState();
    _transitionController.forward();
  }

  @override
  void dispose() {
    _transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _transitionController,
      child: Builder(
        builder: widget.builder,
      ),
    );
  }

  Future<void> close() {
    return _transitionController.reverse();
  }
}

class _Closable extends StatefulWidget {
  const _Closable({
    Key? key,
    required this.child,
    required this.onClose,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onClose;

  @override
  State<_Closable> createState() => _ClosableState();
}

class _ClosableState extends State<_Closable>
    with SingleTickerProviderStateMixin {
  AnimationController? _closeController;

  @override
  void initState() {
    super.initState();
    _closeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _closeController!.addListener(() {
      if (_closeController!.isCompleted) {
        widget.onClose();
      }
    });
  }

  @override
  void dispose() {
    _closeController?.dispose();
    super.dispose();
  }

  double get _width => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        RepaintBoundary(
          child: AnimatedBuilder(
            animation: _closeController!,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_closeController!.value * _width, 0),
                child: child,
              );
            },
            child: SizedBox.expand(
              child: widget.child,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            supportedDevices: const {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
            onHorizontalDragUpdate: _move,
            onHorizontalDragEnd: _settle,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: 50,
            ),
          ),
        ),
      ],
    );
  }

  void _close() {
    _closeController!.forward();
  }

  void _return() {
    _closeController!.reverse();
  }

  void _move(DragUpdateDetails update) {
    _closeController!.value += update.primaryDelta! / _width;
  }

  void _settle(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx / _width;

      _closeController!.fling(velocity: visualVelocity);
    } else if (_closeController!.value < 0.2) {
      _return();
    } else {
      _close();
    }
  }
}
