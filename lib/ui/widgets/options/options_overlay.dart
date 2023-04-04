import 'dart:ui';

import 'package:app_base/app_base.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:interactive_cv/ui/widgets/options/option_item.dart';

class OptionsOverlay extends StatefulWidget {
  const OptionsOverlay({
    Key? key,
    required this.appIcon,
    required this.onClose,
    required this.layerLink,
    required this.options,
  }) : super(key: key);

  final Widget appIcon;
  final VoidCallback onClose;
  final LayerLink layerLink;
  final List<Option> options;

  @override
  State<OptionsOverlay> createState() => _OptionsOverlayState();
}

class _OptionsOverlayState extends State<OptionsOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AnimationController _optionsAnimationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _optionsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        if (mounted) _animationController.forward();
      });
    });

    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _optionsAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClose,
      behavior: HitTestBehavior.opaque,
      child: SizedBox.expand(
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _optionsAnimationController,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _optionsAnimationController.value * 10,
                    sigmaY: _optionsAnimationController.value * 10,
                  ),
                  child: child,
                );
              },
              child: const SizedBox.expand(),
            ),
            CompositedTransformFollower(
              link: widget.layerLink,
              followerAnchor: Alignment.topCenter,
              targetAnchor: Alignment.topCenter,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1 + 0.2 * (_animationController.value),
                    child: child,
                  );
                },
                child: widget.appIcon,
              ),
            ),
            const SizedBox(height: 30),
            CompositedTransformFollower(
              link: widget.layerLink,
              offset: Offset(
                -widget.layerLink.leaderSize!.width * 0.1,
                widget.layerLink.leaderSize!.width * 0.1 + 10,
              ),
              targetAnchor: Alignment.bottomLeft,
              child: IntrinsicWidth(
                child: AnimatedBuilder(
                  animation: _optionsAnimationController,
                  builder: (context, child) {
                    return DecoratedBox(
                      decoration: ShapeDecoration(
                          shape: SmoothRectangleBorder(
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: 30,
                              cornerSmoothing: 0.5,
                            ),
                          ),
                          color: CupertinoDynamicColor.resolve(
                              CupertinoDynamicColor.withBrightness(
                                color: Color(0xC7F9F9F9),
                                darkColor: Color(0xC7252525),
                              ),
                              context)),
                      child: SizeTransition(
                        sizeFactor: _optionsAnimationController,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: widget.options
                        .map((e) => OptionItem(option: e))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
