import 'package:app_base/app_base.dart';
import 'package:flutter/widgets.dart';

abstract class OverlayApplication extends Application {
  late final _overlayEntry = OverlayEntry(
    builder: _buildApp,
  );

  Widget _buildApp(BuildContext context) {
    return _AppTransition(builder: buildApp);
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
