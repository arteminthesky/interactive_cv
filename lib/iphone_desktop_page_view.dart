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

  double currentPageValue = 1;

  bool doNotTranslateRightDrawer = false;
  bool doNotTranslateLeftDrawer = false;

  @override
  void initState() {
    super.initState();

    _desktopsController.addListener(() {
      setState(() {
        currentPageValue = _desktopsController.page ?? 0;
      });
    });

    _leftDrawerPageController.addListener(() {
      setState(() {
        if (_leftDrawerPageController.positions.isNotEmpty) {
          var page = _leftDrawerPageController.page ?? 0;
          doNotTranslateLeftDrawer = page > 0 && page < 1;
        } else {
          doNotTranslateLeftDrawer = false;
        }
      });

      _desktopsController.jumpTo(_leftDrawerPageController.offset);
    });

    _rightDrawerPageController.addListener(() {
      var width = MediaQuery
          .of(context)
          .size
          .width;
      var controllerAttached = _rightDrawerPageController.positions.isNotEmpty;
      var lastPageOffset = (widget.desktops.length) * width * 0.999;

      setState(() {
        doNotTranslateRightDrawer = controllerAttached &&
            (_rightDrawerPageController.page ?? 0) < 1 &&
            (_rightDrawerPageController.page ?? 0) > 0;
      });
      if (controllerAttached) {
        var currentDrawerPage = _rightDrawerPageController.page ?? 0;
        if (currentDrawerPage < 1) {
          var isLastPage =
              (_desktopsController.page ?? 1) > widget.desktops.length;
          if (isLastPage) {
            var offset = _rightDrawerPageController.offset;
            print('LastPageOffset: $lastPageOffset');
            print('Offset: ${lastPageOffset - offset}');
            print('Min: ${min(lastPageOffset, lastPageOffset - offset)}');
            _desktopsController.jumpTo(lastPageOffset + offset);

            print('New page: ${_desktopsController.page}');
          }
        }
      }
    });
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
        Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: AnimatedBuilder(
              animation: Listenable.merge(
                [_leftDrawerPageController, _rightDrawerPageController],
              ),
              builder: (context, snapshot) {
                var pageSnapping = true;
                var leftDrawerAttached =
                    _leftDrawerPageController.positions.isNotEmpty;
                var rightDrawerAttached =
                    _rightDrawerPageController.positions.isNotEmpty;

                if (leftDrawerAttached) {
                  if ((_leftDrawerPageController.page ?? 0) > 0) {
                    pageSnapping = false;
                  }
                }
                if (rightDrawerAttached) {
                  if ((_rightDrawerPageController.page ?? 1) < 1) {
                    pageSnapping = false;
                  }
                }
                return PageView.builder(
                  itemCount: length,
                  controller: _desktopsController,
                  pageSnapping: pageSnapping,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int position) {
                    Widget child = desktops[position];

                    if (position == 1 && currentPageValue < 1) {
                      return Transform.translate(
                        offset: Offset(
                            MediaQuery
                                .of(context)
                                .size
                                .width *
                                -(1 - currentPageValue),
                            0),
                        child: Transform.scale(
                          scale: 1 - (0.2 * (1 - currentPageValue)),
                          child: child,
                        ),
                      );
                    } else if (position == length - 2 &&
                        currentPageValue > length - 2) {
                      return Transform.translate(
                        offset: Offset(
                            MediaQuery
                                .of(context)
                                .size
                                .width *
                                -(length - 2 - currentPageValue),
                            0),
                        child: Transform.scale(
                          scale: 1 - 0.2 * -(length - 2 - currentPageValue),
                          child: child,
                        ),
                      );
                    } else {
                      return child;
                    }
                  },
                );
              }),
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
            animation: _desktopsController,
            builder: (context, child) {
              var width = MediaQuery
                  .of(context)
                  .size
                  .width;
              var desktopAttached = _desktopsController.positions.isNotEmpty;

              if (desktopAttached && (_desktopsController.page ?? 1) < 1) {
                var translateOffset = doNotTranslateLeftDrawer ? 0.0 : -width *
                    min(1, _desktopsController.page ?? 0);

                return Transform.translate(
                  offset:
                  Offset(translateOffset, 0),
                  child: PageView(
                    controller: _leftDrawerPageController,
                    children: const [
                      LeftDrawerPage(),
                      Offstage(),
                    ],
                  ),
                );
              }
              return const Offstage();
            },
          ),
        ),
        RepaintBoundary(
          key: const ValueKey('right_drawer_repaint_boundary'),
          child: AnimatedBuilder(
            animation: _desktopsController,
            builder: (context, child) {
              final width = MediaQuery
                  .of(context)
                  .size
                  .width;
              final desktopAttached = _desktopsController.positions.isNotEmpty;
              final countOfPages = widget.desktops.length + 2;

              if (desktopAttached) {
                final currentPage = _desktopsController.page ?? 1;
                final isLastPage = currentPage > countOfPages - 2;

                print('current page: ${currentPage}');
                print(isLastPage);

                if (isLastPage) {
                  var translateOffset = doNotTranslateRightDrawer ? 0.0 :
                  width * min(1, countOfPages - 1 - currentPage);

                  print(translateOffset);
                  return Transform.translate(
                    offset: Offset(translateOffset, 0),
                    child: PageView(
                      controller: _rightDrawerPageController,
                      children: const [
                        Offstage(),
                        RightDrawerPage(),
                      ],
                    ),
                  );
                }
              }
              return const Offstage();
            },
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
