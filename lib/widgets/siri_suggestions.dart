import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:iphone_desktop/left_drawer_page.dart';

class SiriSuggestions extends StatefulWidget {
  const SiriSuggestions({Key? key, required this.controller}) : super(key: key);

  final TopDrawerController controller;

  @override
  State<SiriSuggestions> createState() => _SiriSuggestionsState();
}

class _SiriSuggestionsState extends State<SiriSuggestions>
    with TickerProviderStateMixin {
  ScrollController? _scrollController;
  bool animating = false;

  late AnimationController _animation;
  late AnimationController _endAnimation;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onStateChanged);
    _animation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _endAnimation = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 1.0);
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
      } else if (state == TopDrawerAnimationState.end) {}
    } else {
      print(_animation.status);
      if (_animation.status != AnimationStatus.completed) {
        _animation.forward();
      } else {
        if (_endAnimation.status != AnimationStatus.dismissed) {
          _animation.reverse();
        }
      }

      _snap();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onStateChanged);
    _scrollController?.dispose();
    _animation?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        print(_scrollController?.position.maxScrollExtent);
        print(_scrollController?.offset);
        print(MediaQuery.of(context).size.height);
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${index.toString()} element'),
                    );
                  },
                  childCount: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      LeftDrawerControllerScope.of(context).hideTopDrawer();
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
          duration: Duration(milliseconds: 600),
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
          duration: Duration(milliseconds: 600),
          curve: Curves.easeOutExpo,
        )
            .then((_) {
          animating = false;
        });
      });
    }
  }
}
