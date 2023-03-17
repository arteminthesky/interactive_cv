import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iphone_desktop/drawers/left_drawer_page.dart';
import 'package:iphone_desktop/drawers/right_drawer_page.dart';
import 'package:iphone_desktop/iphone_wallpaper.dart';
import 'package:iphone_desktop/widgets/widgets.dart';
import 'package:models/models.dart';

class IPhoneDesktopPageView extends StatefulWidget {
  const IPhoneDesktopPageView({
    Key? key,
    required this.desktops,
    required this.wallpaper,
  }) : super(key: key);

  final List<Desktop> desktops;
  final Wallpaper wallpaper;

  @override
  State<IPhoneDesktopPageView> createState() => _IPhoneDesktopPageViewState();
}

class _IPhoneDesktopPageViewState extends State<IPhoneDesktopPageView> {
  final PageController _desktopsController =
      PageController(viewportFraction: 0.999, initialPage: 1);

  final ValueNotifier<bool> _mainPageSnapping = ValueNotifier(true);
  final ValueNotifier<bool> _mainPageScrollPhysicsEnabled = ValueNotifier(true);

  bool doNotTranslateRightDrawer = false;
  bool doNotTranslateLeftDrawer = false;

  double get _width => MediaQuery.of(context).size.width;

  var _scrollPhysics = const ClampingScrollPhysics();

  @override
  void initState() {
    super.initState();
  }

  void unlockScroll() {
    _mainPageSnapping.value = true;
    _mainPageScrollPhysicsEnabled.value = true;
  }

  void lockScroll() {
    _mainPageSnapping.value = false;
    _mainPageScrollPhysicsEnabled.value = false;
  }

  var leftDrawerStartPosition = 0.0;
  var leftDrawerCurrentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    var length = widget.desktops.length + 2;

    var desktops = [
      const LeftDrawerPage(),
      for (var desktop in widget.desktops) DesktopWidget(desktop: desktop),
      const RightDrawerPage(),
    ];

    return Stack(
      children: [
        IPhoneWallpaper(
          wallpaper: widget.wallpaper,
        ),
        AnimatedBuilder(
            animation: Listenable.merge(
                [_mainPageScrollPhysicsEnabled, _mainPageSnapping]),
            builder: (context, snapshot) {
              return RepaintBoundary(
                key: ValueKey('main_pager'),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: AnimatedBuilder(
                    animation: _desktopsController,
                    builder: (context, child) {
                      return PageView.builder(
                        itemCount: length,
                        pageSnapping: _mainPageSnapping.value,
                        physics: _mainPageScrollPhysicsEnabled.value
                            ? _scrollPhysics
                            : const NeverScrollableScrollPhysics(),
                        controller: _desktopsController,
                        itemBuilder: (BuildContext context, int position) {
                          Widget child = desktops[position];
                          var currentPageValue = 1.0;
                          var scale = 1.0;
                          var translationOffset = Offset.zero;
                          var scrollPosition = _desktopsController.position;
                          if (!scrollPosition.hasPixels ||
                              scrollPosition.hasContentDimensions) {
                            currentPageValue = _desktopsController.page ?? 1;
                          }

                          if (position == 1 && currentPageValue < 1) {
                            final pageFraction = 1 - currentPageValue;
                            translationOffset =
                                Offset(_width * -pageFraction, 0);
                            scale = 1 - (0.2 * pageFraction);
                          } else if (position == length - 2 &&
                              currentPageValue > length - 2) {
                            var pageFraction = length - 2 - currentPageValue;
                            translationOffset =
                                Offset(_width * -pageFraction, 0);
                            scale = 1 - (0.2 * -pageFraction);
                          }

                          return Transform.translate(
                            offset: translationOffset,
                            child: Transform.scale(
                              scale: scale,
                              child: child,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FidgetPanel(
              blurred: true,
              radius: 40,
              child: ColoredBox(
                color: Colors.white24,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < 4; i++)
                        const AppIcon(
                          child: Offstage(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        _DynamicBlur(
          controller: _desktopsController,
          desktopsCount: desktops.length,
        ),
        AnimatedBuilder(
          animation: _desktopsController,
          builder: (context, child) {
            var translationOffset = _width;
            if (_desktopsController.positions.isNotEmpty) {
              var page = _desktopsController.page ?? 0;
              if (page >= 0 && page < 1) {
                translationOffset = _width * -page;
              }
            }
            return Transform.translate(
              offset: Offset(
                translationOffset,
                0,
              ),
              child: child,
            );
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanStart: (start) {
              leftDrawerStartPosition = start.globalPosition.dx;
              lockScroll();
            },
            onPanUpdate: (update) {
              leftDrawerCurrentPosition =
                  leftDrawerStartPosition - update.globalPosition.dx;
              _desktopsController.jumpTo(max(0, leftDrawerCurrentPosition));
            },
            onPanDown: (details) {
              unlockScroll();
              leftDrawerCurrentPosition = 0;
            },
            onPanEnd: (details) {
              unlockScroll();
              var position = _desktopsController.position;
              if(position is ScrollPositionWithSingleContext) {
                position.goBallistic(-details.velocity.pixelsPerSecond.dx);
              }
              leftDrawerCurrentPosition = 0;
            },
            onPanCancel: () {
              unlockScroll();
              leftDrawerCurrentPosition = 0;
            },
            child: const LeftDrawerPage(),
          ),
        ),
      ],
    );
  }
}

class _DynamicBlur extends StatefulWidget {
  const _DynamicBlur({
    Key? key,
    required this.controller,
    required this.desktopsCount,
  }) : super(key: key);

  final PageController controller;
  final int desktopsCount;

  @override
  State<_DynamicBlur> createState() => _DynamicBlurState();
}

class _DynamicBlurState extends State<_DynamicBlur> {
  static const _finalBlur = 20.0;

  @override
  Widget build(BuildContext context) {
    var controller = widget.controller;

    return RepaintBoundary(
      key: const ValueKey('dynamic_blur'),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          var page = controller.page ?? 1;
          var blur = 0.0;

          if (page < 1) {
            blur = _finalBlur * (1 - page) + 0.01;
          } else if (page > widget.desktopsCount - 2) {
            blur = _finalBlur * (page - widget.desktopsCount + 2) + 0.01;
          }
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}
