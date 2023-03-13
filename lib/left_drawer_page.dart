// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:iphone_desktop/widgets/ios_widget.dart';
import 'package:iphone_desktop/widgets/siri_suggestions.dart';

enum TopDrawerAnimationState { end, begin, idle, active }

class TopDrawerState {
  TopDrawerState(this.offset, this.animationState);

  final Offset offset;
  final TopDrawerAnimationState? animationState;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopDrawerState &&
          runtimeType == other.runtimeType &&
          offset == other.offset &&
          animationState == other.animationState;

  @override
  int get hashCode => offset.hashCode ^ animationState.hashCode;
}

class TopDrawerController extends ValueNotifier<TopDrawerState> {
  TopDrawerController(super.value);
}

class LeftDrawerControllerScope extends InheritedWidget {
  const LeftDrawerControllerScope({
    super.key,
    required this.state,
    required super.child,
  });

  static _LeftDrawerControllerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LeftDrawerControllerScope>()!
        .state;
  }

  final _LeftDrawerControllerState state;

  @override
  bool updateShouldNotify(LeftDrawerControllerScope oldWidget) {
    return state != oldWidget.state;
  }
}

class _LeftDrawerController extends StatefulWidget {
  const _LeftDrawerController({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<_LeftDrawerController> createState() => _LeftDrawerControllerState();
}

class _LeftDrawerControllerState extends State<_LeftDrawerController> {
  final TopDrawerController controller = TopDrawerController(
    TopDrawerState(Offset.zero, null),
  );

  late final _topDrawerEntry = OverlayEntry(builder: (context) {
    return SiriSuggestions(
      controller: controller,
    );
  });

  Offset _gestureStart = Offset.zero;
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (down) {
        _gestureStart = down.localPosition;
      },
      onPointerMove: (move) {
        var delta = move.localPosition - _gestureStart;
        if (delta.dy >= 0 &&
            controller.value.animationState != TopDrawerAnimationState.idle) {
          _updateBeginAnimation(delta);
          _showTopDrawer();
        }
      },
      onPointerUp: (up) {
        _idleAnimation();
      },
      child: LeftDrawerControllerScope(
        state: this,
        child: widget.child,
      ),
    );
  }

  void _updateBeginAnimation(Offset offset) {
    controller.value = TopDrawerState(offset, TopDrawerAnimationState.begin);
  }

  void _updateAnimation() {}

  void _idleAnimation() {
    controller.value =
        TopDrawerState(Offset.zero, TopDrawerAnimationState.idle);
  }

  void _showTopDrawer() {
    if (!opened) {
      opened = true;
      Overlay.of(context).insert(_topDrawerEntry);
    }
  }

  void hideTopDrawer() {
    _topDrawerEntry.remove();
    opened = false;
  }
}

class LeftDrawerPage extends StatelessWidget {
  const LeftDrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _LeftDrawerController(
      child: _LeftDrawerPageBody(),
    );
  }
}

class _LeftDrawerPageBody extends StatefulWidget {
  const _LeftDrawerPageBody({Key? key}) : super(key: key);

  @override
  State<_LeftDrawerPageBody> createState() => _LeftDrawerPageBodyState();
}

class _LeftDrawerPageBodyState extends State<_LeftDrawerPageBody> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        controller: _controller,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: const [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: AspectRatio(
                aspectRatio: 2,
                child: IosWidget(
                  child: _WeatherWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherWidget extends StatelessWidget {
  const _WeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
      ),
      child: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Weather'),
            Text('Good'),
          ],
        ),
      ),
    );
  }
}
