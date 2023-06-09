import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:interactive_cv/ui/widgets/widgets.dart';
import 'package:models/models.dart';

import 'iphone_wallpaper.dart';

class IPhoneDesktopPageView extends StatefulWidget {
  const IPhoneDesktopPageView({
    Key? key,
    required this.desktops,
    required this.wallpaper,
    required this.leftDrawer,
    required this.rightDrawer,
    required this.topDrawer,
  }) : super(key: key);

  final List<Desktop> desktops;
  final Wallpaper? wallpaper;
  final Widget leftDrawer;
  final Widget rightDrawer;
  final Widget topDrawer;

  @override
  State<IPhoneDesktopPageView> createState() => _IPhoneDesktopPageViewState();
}

class _IPhoneDesktopPageViewState extends State<IPhoneDesktopPageView> {
  final PageController _desktopsController =
      PageController(viewportFraction: 0.999, initialPage: 1);

  final ValueNotifier<bool> _mainPageSnapping = ValueNotifier(true);
  final ValueNotifier<bool> _mainPageScrollPhysicsEnabled = ValueNotifier(true);

  late final mainPagerListenable = Listenable.merge([
    _mainPageScrollPhysicsEnabled,
    _mainPageSnapping,
  ]);

  double get _width => MediaQuery.of(context).size.width;

  Offset? screenCenter;
  late List<Widget> desktops;
  var length = 0;

  bool cancelTutorialAnimation = false;

  @override
  void initState() {
    super.initState();
    _prepareDesktops();

    // EXPERIMENTAL
    Future.delayed(const Duration(seconds: 3), () {
      if(!cancelTutorialAnimation) {
        return _desktopsController.animateTo(_width * 0.8,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuart);
      }
    }).then((value) {
      if(!cancelTutorialAnimation) {
        return _desktopsController.animateTo(_width * 1.2,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuart);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenSize = MediaQuery.of(context).size;
    screenCenter = Offset(
      screenSize.width / 2,
      screenSize.height / 2,
    );
  }

  @override
  void didUpdateWidget(IPhoneDesktopPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.desktops != oldWidget.desktops) {
      _prepareDesktops();
    }
  }

  void _prepareDesktops() {
    desktops = [
      const Offstage(),
      for (var desktop in widget.desktops) DesktopWidget(desktop: desktop),
      const Offstage(),
    ];
    length = desktops.length;
  }

  @override
  void dispose() {
    _mainPageSnapping.dispose();
    _mainPageScrollPhysicsEnabled.dispose();
    _desktopsController.dispose();
    super.dispose();
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

  var rightDrawerStartPosition = 0.0;
  var rightDrawerCurrentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (pointer) {
        cancelTutorialAnimation = true;
      },
      child: TopDrawerScope(
        content: widget.topDrawer,
        child: RepaintBoundary(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                IPhoneWallpaper(
                  wallpaper: widget.wallpaper,
                ),
                RepaintBoundary(
                  key: const ValueKey('main_pager_repaint_boundary'),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: AnimatedBuilder(
                      animation: mainPagerListenable,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: AnimatedBuilder(
                            animation: _desktopsController,
                            builder: (context, child) {
                              return PageView.builder(
                                itemCount: length,
                                pageSnapping: _mainPageSnapping.value,
                                physics: _mainPageScrollPhysicsEnabled.value
                                    ? const ClampingScrollPhysics()
                                    : const NeverScrollableScrollPhysics(),
                                controller: _desktopsController,
                                itemBuilder:
                                    (BuildContext context, int position) {
                                  Widget child = desktops[position];
                                  var currentPageValue = 1.0;
                                  var scale = 1.0;
                                  var translationOffset = 0.0;
                                  var scrollPosition =
                                      _desktopsController.position;
                                  if (!scrollPosition.hasPixels ||
                                      scrollPosition.hasContentDimensions) {
                                    currentPageValue =
                                        _desktopsController.page ?? 1;
                                  }

                                  if (position == 1 && currentPageValue < 1) {
                                    final pageFraction = 1 - currentPageValue;
                                    translationOffset = _width * -pageFraction;
                                    scale = 1 - (0.1 * pageFraction);
                                  } else if (position == length - 2 &&
                                      currentPageValue > length - 2) {
                                    var pageFraction =
                                        length - 2 - currentPageValue;
                                    translationOffset = _width * -pageFraction;
                                    scale = 1 - (0.1 * -pageFraction);
                                  }

                                  return Transform(
                                    transform: createMatrix(
                                      translationOffset,
                                      scale,
                                      screenCenter ?? Offset.zero,
                                    ),
                                    child: child,
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const ImportantAppsPanel(),
                _DynamicBlur(
                  controller: _desktopsController,
                  desktopsCount: desktops.length,
                ),
                RepaintBoundary(
                  key: const ValueKey('left_drawer_repaint_boundary'),
                  child: AnimatedBuilder(
                    animation: _desktopsController,
                    builder: (context, child) {
                      var translationOffset = _width;
                      if (_desktopsController.positions.isNotEmpty) {
                        var page = _desktopsController.page ?? 1;
                        if (page >= 0 && page < 1) {
                          translationOffset = _width * -page;
                        }
                      }

                      return Transform(
                        transform: Matrix4.identity()
                          ..translate(translationOffset),
                        child: child,
                      );
                    },
                    child: GestureDetector(
                      supportedDevices: const {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.touch,
                      },
                      behavior: HitTestBehavior.opaque,
                      onPanStart: (start) {
                        leftDrawerStartPosition = start.globalPosition.dx;
                        lockScroll();
                      },
                      onPanUpdate: (update) {
                        leftDrawerCurrentPosition =
                            leftDrawerStartPosition - update.globalPosition.dx;
                        _desktopsController
                            .jumpTo(max(0, leftDrawerCurrentPosition));
                      },
                      onPanDown: (details) {
                        unlockScroll();
                        leftDrawerCurrentPosition = 0;
                      },
                      onPanEnd: (details) {
                        unlockScroll();
                        var position = _desktopsController.position;
                        if (position is ScrollPositionWithSingleContext) {
                          position
                              .goBallistic(-details.velocity.pixelsPerSecond.dx);
                        }
                        leftDrawerCurrentPosition = 0;
                      },
                      onPanCancel: () {
                        unlockScroll();
                        leftDrawerCurrentPosition = 0;
                      },
                      child: widget.leftDrawer,
                    ),
                  ),
                ),
                RepaintBoundary(
                  key: const ValueKey('right_drawer_repaint_boundary'),
                  child: AnimatedBuilder(
                    animation: _desktopsController,
                    builder: (context, child) {
                      var translationOffset = _width;
                      if (_desktopsController.positions.isNotEmpty) {
                        var page = _desktopsController.page ?? 0;
                        var pagesLength = desktops.length;
                        if (page > pagesLength - 2 && page <= pagesLength - 1) {
                          translationOffset = _width * (desktops.length - 1) -
                              _desktopsController.offset;
                        }
                      }
                      return Transform(
                        transform: Matrix4.identity()
                          ..translate(translationOffset),
                        child: child,
                      );
                    },
                    child: GestureDetector(
                      supportedDevices: const {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.touch,
                      },
                      behavior: HitTestBehavior.opaque,
                      onPanStart: (start) {
                        rightDrawerStartPosition = start.globalPosition.dx;
                        lockScroll();
                      },
                      onPanUpdate: (update) {
                        var pagesLength = desktops.length;

                        rightDrawerCurrentPosition =
                            rightDrawerStartPosition - update.globalPosition.dx;
                        var lastPageOffset = (pagesLength - 1) * _width;
                        _desktopsController.jumpTo(min(lastPageOffset - 1,
                            lastPageOffset + rightDrawerCurrentPosition));
                      },
                      onPanDown: (details) {
                        unlockScroll();
                        rightDrawerCurrentPosition = 0;
                      },
                      onPanEnd: (details) {
                        unlockScroll();
                        var position = _desktopsController.position;
                        if (position is ScrollPositionWithSingleContext) {
                          position
                              .goBallistic(-details.velocity.pixelsPerSecond.dx);
                        }
                        rightDrawerCurrentPosition = 0;
                      },
                      onPanCancel: () {
                        unlockScroll();
                        rightDrawerCurrentPosition = 0;
                      },
                      child: widget.rightDrawer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Matrix4 createMatrix(double translationX, double scale, Offset scaleCenter) {
    return Matrix4.identity()
      ..translate(translationX, 0.0)
      ..translate(scaleCenter.dx, scaleCenter.dy)
      ..scale(scale)
      ..translate(-scaleCenter.dx, -scaleCenter.dy);
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
    return RepaintBoundary(
      key: const ValueKey('dynamic_blur'),
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          var page = widget.controller.page ?? 1;
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
