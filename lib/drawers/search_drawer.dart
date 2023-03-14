import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:iphone_desktop/drawers/left_drawer_page.dart';

const _snapDuration = Duration(milliseconds: 600);
const _animationDuration = Duration(milliseconds: 300);

// TODO(artemov): refactor this peace of code (state management)
class SearchDrawer extends StatefulWidget {
  const SearchDrawer({
    Key? key,
    required this.controller,
    required this.entry,
    required this.slivers,
  }) : super(key: key);

  final OverlayEntry entry;
  final TopDrawerController controller;
  final List<Widget> slivers;

  @override
  State<SearchDrawer> createState() => _SearchDrawerState();
}

class _SearchDrawerState extends State<SearchDrawer>
    with TickerProviderStateMixin {
  ScrollController? _scrollController;
  bool animating = false;

  late AnimationController _animation;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onStateChanged);
    _animation = AnimationController(vsync: this, duration: _animationDuration);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController ??= ScrollController(
        initialScrollOffset: MediaQuery.of(context).size.height);
  }

  void _onStateChanged() {
    var state = widget.controller.value.animationState;
    var offset = widget.controller.value.offset;
    if (state != TopDrawerAnimationState.idle) {
      _animation.value = min((offset.dy - 150) / 150, 1);
      if (state == TopDrawerAnimationState.begin) {
        _scrollController?.jumpTo(
          MediaQuery.of(context).size.height - offset.dy,
        );
      } else if (state == TopDrawerAnimationState.end) {
        _animation.reverse(from: 1).then((_) {
          if (mounted) {
            widget.entry.remove();
            widget.controller.value = TopDrawerState(Offset.zero, null);
          }
        });
      }
    } else {
      if (_animation.status != AnimationStatus.completed) {
        _animation.forward();
      }
      _snap();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onStateChanged);
    _scrollController?.dispose();
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (widget.controller.value.animationState ==
            TopDrawerAnimationState.idle) {
          final dragIsEnd = notification is ScrollUpdateNotification &&
              notification.dragDetails == null;
          if (dragIsEnd || notification is ScrollEndNotification) {
            final offset = _scrollController?.offset ?? 0.0;
            if (offset < MediaQuery.of(context).size.height) {
              _snap();
            } else if (offset >
                _scrollController!.position.maxScrollExtent -
                    MediaQuery.of(context).size.height) {
              _snapToEnd();
            }
          }
        }

        return true;
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final sigma = _animation.value * 50 + 0.01;
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: child,
          );
        },
        child: FadeTransition(
          opacity: _animation,
          child: CustomScrollView(
            controller: _scrollController,
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Placeholder(),
                ),
              ),
              ...widget.slivers,
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      widget.controller.value = TopDrawerState(
                        widget.controller.value.offset,
                        TopDrawerAnimationState.end,
                      );
                    },
                    child: const Placeholder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _snap() {
    if (!animating) {
      animating = true;
      scheduleMicrotask(() {
        _scrollController
            ?.animateTo(
          MediaQuery.of(context).size.height,
          duration: _snapDuration,
          curve: Curves.easeOutExpo,
        )
            .then((_) {
          animating = false;
        });
      });
    }
  }

  void _snapToEnd() {
    if (!animating) {
      animating = true;
      scheduleMicrotask(() {
        _scrollController
            ?.animateTo(
          max(
              _scrollController!.position.maxScrollExtent -
                  MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.height),
          duration: _snapDuration,
          curve: Curves.easeOutExpo,
        )
            .then((_) {
          animating = false;
        });
      });
    }
  }
}
