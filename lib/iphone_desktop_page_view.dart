import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iphone_desktop/iphone_wallpaper.dart';
import 'package:iphone_desktop/left_drawer_page.dart';
import 'package:iphone_desktop/right_drawer_page.dart';
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

  final PageController _drawersPageController =
      PageController(viewportFraction: 0.999, initialPage: 1);

  double currentPageValue = 1;

  @override
  void initState() {
    super.initState();

    _drawersPageController.addListener(() {
      _desktopsController.jumpTo(_drawersPageController.offset);
    });

    _desktopsController.addListener(() {
      setState(() {
        currentPageValue = _desktopsController.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var length = widget.desktops.length + 2;

    var desktops = [
      const Offstage(),
      for (var desktop in widget.desktops) DesktopWidget(desktop: desktop),
      const Offstage(),
    ];

    var drawers = [
      const LeftDrawerPage(),
      for (int i = 0; i < widget.desktops.length; i++) const Offstage(),
      const RightDrawerPage(),
    ];

    return Stack(
      children: [
        IPhoneWallpaper(
          wallpaper: widget.wallpaper,
        ),
        PageView.builder(
          itemCount: length,
          controller: _desktopsController,
          pageSnapping: false,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int position) {
            Widget child = desktops[position];

            if (position == 1 && currentPageValue < 1) {
              return Transform.translate(
                offset: Offset(
                    MediaQuery.of(context).size.width * -(1 - currentPageValue),
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
                    MediaQuery.of(context).size.width *
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
        ),
        _DynamicBlur(
          controller: _desktopsController,
          desktopsCount: desktops.length,
        ),
        PageView(
          physics: const ClampingScrollPhysics(),
          controller: _drawersPageController,
          children: drawers,
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

    return AnimatedBuilder(
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
    );
  }
}
