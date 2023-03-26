// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:github_fidget/github_fidget.dart';
import 'package:iphone_desktop/drawers/search_drawer.dart';
import 'package:iphone_desktop/ui/widgets/widgets.dart';

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

class TopDrawerStateController extends ValueNotifier<TopDrawerState> {
  TopDrawerStateController(super.value);
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
  final TopDrawerStateController topDrawerController = TopDrawerStateController(
    TopDrawerState(Offset.zero, null),
  );

  final ScrollController _scrollController = ScrollController();
  late final _topDrawerEntry = OverlayEntry(builder: _buildEntry);

  Widget _buildEntry(context) {
    return SearchDrawer(
      entry: _topDrawerEntry,
      controller: topDrawerController,
      slivers: const [
        SliverSafeArea(
          bottom: false,
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: WeatherFidget(),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            child: SiriSuggestionsFidget(),
          ),
        ),
      ],
    );
  }

  Offset _gestureStart = Offset.zero;
  bool opened = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (down) {
        _gestureStart = down.localPosition;
      },
      onPointerMove: (move) {
        var delta = move.localPosition - _gestureStart;
        if (delta.dy >= 0 &&
            _scrollController.positions.isNotEmpty &&
            topDrawerController.value.animationState !=
                TopDrawerAnimationState.idle &&
            _scrollController.offset < 0) {
          _showTopDrawer();
          _updateBeginAnimation(delta);
        }
      },
      onPointerUp: (up) {
        if (topDrawerController.value.animationState != null) {
          _idleAnimation();
        }
      },
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        child: PrimaryScrollController(
          automaticallyInheritForPlatforms: TargetPlatform.values.toSet(),
          controller: _scrollController,
          child: widget.child,
        ),
      ),
    );
  }

  void _updateBeginAnimation(Offset offset) {
    topDrawerController.value =
        TopDrawerState(offset, TopDrawerAnimationState.begin);
  }

  void _updateAnimation() {}

  void _idleAnimation() {
    topDrawerController.value =
        TopDrawerState(Offset.zero, TopDrawerAnimationState.idle);
  }

  void _showTopDrawer() {
    if (topDrawerController.value.animationState == null) {
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

class _LeftDrawerPageBody extends StatelessWidget {
  const _LeftDrawerPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(10.0),
            sliver: SliverToBoxAdapter(
              child: GithubFidget(
                githubUser: 'arteminthesky',
                repo: 'iphone_desktop',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
