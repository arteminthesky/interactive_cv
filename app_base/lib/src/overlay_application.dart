import 'dart:math';
import 'dart:ui';

import 'package:app_base/app_base.dart';
import 'package:flutter/widgets.dart';

abstract class OverlayApplication extends Application {

  OverlayApplication();

  late final _overlayEntry = OverlayEntry(
    builder: _buildApp,
  );

  final GlobalKey<_AppTransitionState> _appTransitionKey = GlobalKey();

  Widget _buildApp(BuildContext context) {
    return _Closable(
      onClose: _overlayEntry.remove,
      child: _AppTransition(
        key: _appTransitionKey,
        builder: buildApp,
      ),
    );
  }

  Widget buildApp(BuildContext context);

  void close(BuildContext context) {
    var state = context.findAncestorStateOfType<_AppTransitionState>()!;

    state.close().then((_) => _overlayEntry.remove());
  }

  @override
  Future<void> open(BuildContext context, {String? deepLink}) {
    Overlay.of(context).insert(_overlayEntry);
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
  final ValueNotifier<double> _translateListenable = ValueNotifier(0);
  AnimationController? _closeController;

  @override
  void initState() {
    super.initState();
    _closeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        RepaintBoundary(
          child: AnimatedBuilder(
            animation: _translateListenable,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_translateListenable.value, 0),
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
            behavior: HitTestBehavior.opaque,
            supportedDevices: const {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
            onHorizontalDragUpdate: (update) {
              _translateListenable.value =
                  max(0, _translateListenable.value + update.delta.dx);
            },
            onHorizontalDragEnd: (details) {
              _closeController?.forward();
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: 50,
            ),
          ),
        ),
      ],
    );
  }
}
