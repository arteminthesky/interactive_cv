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

  final PageController _leftDrawerPageController =
      PageController(viewportFraction: 0.999, initialPage: 0);

  final PageController _rightDrawerPageController =
      PageController(viewportFraction: 0.999, initialPage: 1);

  final ValueNotifier<bool> _mainPageSnapping = ValueNotifier(true);
  final ValueNotifier<bool> _mainPageScrollPhysicsEnabled = ValueNotifier(true);

  final ValueNotifier<bool> _leftDrawerTranslationLocker = ValueNotifier(false);
  final ValueNotifier<bool> _rightDrawerTranslationLocker =
      ValueNotifier(false);

  bool doNotTranslateRightDrawer = false;
  bool doNotTranslateLeftDrawer = false;

  double get _width => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    _leftDrawerPageController.addListener(() {
      if (_leftDrawerPageController.positions.isNotEmpty) {
        var page = _leftDrawerPageController.page ?? 0;
        _leftDrawerTranslationLocker.value = page > 0 && page < 1;

        if (page < 1 && page > 0) {
          lockScroll();
        } else {
          unlockScroll();
        }
      } else {
        _leftDrawerTranslationLocker.value = false;
      }

      _desktopsController.jumpTo(_leftDrawerPageController.offset);
    });

    _rightDrawerPageController.addListener(() {
      var controllerAttached = _rightDrawerPageController.positions.isNotEmpty;
      var lastPageOffset = (widget.desktops.length) * _width * 0.999;

      _rightDrawerTranslationLocker.value = controllerAttached &&
          (_rightDrawerPageController.page ?? 0) < 1 &&
          (_rightDrawerPageController.page ?? 0) > 0;
      if (controllerAttached) {
        var currentDrawerPage = _rightDrawerPageController.page ?? 0;
        if (currentDrawerPage < 1) {
          var isLastPage =
              (_desktopsController.page ?? 1) > widget.desktops.length;
          if (isLastPage) {
            var offset = _rightDrawerPageController.offset;
            _desktopsController.jumpTo(lastPageOffset + offset);
          }
        }
        final page = _rightDrawerPageController.page ?? 1;
        if (page < 1 && page > 0) {
          lockScroll();
        } else {
          unlockScroll();
        }
      }
    });
  }

  void unlockScroll() {
    _mainPageSnapping.value = true;
    _mainPageScrollPhysicsEnabled.value = true;
  }

  void lockScroll() {
    _mainPageSnapping.value = false;
    _mainPageScrollPhysicsEnabled.value = false;
  }

  @override
  Widget build(BuildContext context) {
    var length = widget.desktops.length + 2;

    var desktops = [
      const Offstage(),
      for (var desktop in widget.desktops) DesktopWidget(desktop: desktop),
      const Offstage()
    ];

    return Stack(
      children: [
        IPhoneWallpaper(
          wallpaper: widget.wallpaper,
        ),
        RepaintBoundary(
          key: ValueKey('main_pager'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: AnimatedBuilder(
              animation: Listenable.merge(
                [
                  _mainPageSnapping,
                  _mainPageScrollPhysicsEnabled,
                  _desktopsController,
                ],
              ),
              builder: (context, snapshot) {
                var pageSnapping = _mainPageSnapping.value;
                ScrollPhysics scrollPhysics;
                if (_mainPageScrollPhysicsEnabled.value) {
                  scrollPhysics = const ClampingScrollPhysics();
                } else {
                  scrollPhysics = const NeverScrollableScrollPhysics();
                }

                return PageView.builder(
                  itemCount: length,
                  controller: _desktopsController,
                  pageSnapping: pageSnapping,
                  physics: scrollPhysics,
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
                      translationOffset = Offset(_width * -pageFraction, 0);
                      scale = 1 - (0.2 * pageFraction);
                    } else if (position == length - 2 &&
                        currentPageValue > length - 2) {
                      var pageFraction = length - 2 - currentPageValue;
                      translationOffset = Offset(_width * -pageFraction, 0);
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
        ),
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
        RepaintBoundary(
          key: const ValueKey('left_drawer_repaint_boundary'),
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _desktopsController,
              _leftDrawerTranslationLocker,
            ]),
            builder: (context, child) {
              var width = MediaQuery.of(context).size.width;
              var desktopAttached = _desktopsController.positions.isNotEmpty;

              if (desktopAttached && (_desktopsController.page ?? 1) < 1) {
                var translateOffset = _leftDrawerTranslationLocker.value
                    ? 0.0
                    : -width * min(1, _desktopsController.page ?? 0);

                return Transform.translate(
                  offset: Offset(translateOffset, 0),
                  child: child,
                );
              }
              return const Offstage();
            },
            child: PageView(
              controller: _leftDrawerPageController,
              children: const [
                LeftDrawerPage(),
                Offstage(),
              ],
            ),
          ),
        ),
        RepaintBoundary(
          key: const ValueKey('right_drawer_repaint_boundary'),
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _desktopsController,
              _rightDrawerTranslationLocker,
            ]),
            builder: (context, child) {
              final width = MediaQuery.of(context).size.width;
              final desktopAttached = _desktopsController.positions.isNotEmpty;
              final countOfPages = widget.desktops.length + 2;

              if (desktopAttached) {
                final currentPage = _desktopsController.page ?? 1;
                final isLastPage = currentPage > countOfPages - 2;

                if (isLastPage) {
                  var translateOffset = _rightDrawerTranslationLocker.value
                      ? 0.0
                      : width * min(1, countOfPages - 1 - currentPage);

                  return Transform.translate(
                    offset: Offset(translateOffset, 0),
                    child: child,
                  );
                }
              }
              return const Offstage();
            },
            child: PageView(
              controller: _rightDrawerPageController,
              children: const [
                Offstage(),
                RightDrawerPage(),
              ],
            ),
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
