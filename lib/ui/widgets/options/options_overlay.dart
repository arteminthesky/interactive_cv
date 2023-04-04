import 'dart:ui';

import 'package:app_base/app_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:interactive_cv/ui/widgets/options/options_list.dart';

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

    _optionsAnimationController.addListener(() {
      if(_optionsAnimationController.isDismissed) {
        _animationController.reverse().then((value) {
          widget.onClose();
        });
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
      onTap: () {
        _optionsAnimationController.reverse();
      },
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
              showWhenUnlinked: false,
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
            CompositedTransformFollower(
              link: widget.layerLink,
              showWhenUnlinked: false,
              offset: Offset(
                -widget.layerLink.leaderSize!.width * 0.1,
                widget.layerLink.leaderSize!.width * 0.1 + 10,
              ),
              targetAnchor: Alignment.bottomLeft,
              child: OptionsList(
                options: widget.options,
                sizeTransition: _optionsAnimationController,
                onItemClicked: () {
                  _optionsAnimationController.reverse();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
