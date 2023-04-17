part of options;

const _kAppIconMaxScale = 0.2;

class OptionsOverlay extends StatefulWidget {
  const OptionsOverlay({
    Key? key,
    required this.appIcon,
    required this.onClose,
    required this.layerLink,
    required this.options,
    required this.appPosition,
  }) : super(key: key);

  final Widget appIcon;
  final VoidCallback onClose;
  final LayerLink layerLink;
  final List<Option> options;
  final Offset appPosition;

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
      if (_optionsAnimationController.isDismissed) {
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
      onTap: _onDismiss,
      behavior: HitTestBehavior.opaque,
      child: SizedBox.expand(
        child: Stack(
          children: [
            _DynamicBlur(
              blurAnimation: _optionsAnimationController,
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
                    scale: 1 + _kAppIconMaxScale * (_animationController.value),
                    child: child,
                  );
                },
                child: widget.appIcon,
              ),
            ),
            CompositedTransformFollower(
              link: widget.layerLink,
              showWhenUnlinked: false,
              offset: _calculateOffset(),
              followerAnchor: _calculateOptionsFollowerAnchor(),
              targetAnchor: _calculateOptionsTargetAnchor(),
              child: OptionsList(
                options: widget.options,
                sizeTransition: _optionsAnimationController,
                onItemClicked: _onDismiss,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDismiss() {
    _optionsAnimationController.reverse();
  }

  Alignment _calculateOptionsFollowerAnchor() {
    final quarter = _calculateQuarter();

    switch(quarter) {
      case 0: return Alignment.topLeft;
      case 1: return Alignment.topRight;
      case 2: return Alignment.bottomLeft;
      case 3: return Alignment.bottomRight;
    }

    return Alignment.bottomLeft;
  }

  Alignment _calculateOptionsTargetAnchor() {
    final quarter = _calculateQuarter();

    switch(quarter) {
      case 0: return Alignment.bottomLeft;
      case 1: return Alignment.bottomRight;
      case 2: return Alignment.topLeft;
      case 3: return Alignment.topRight;
    }

    return Alignment.bottomLeft;
  }

  Offset _calculateOffset() {
    final quarter = _calculateQuarter();

    final appIconSize = widget.layerLink.leaderSize ?? Size.zero;
    final appIconOffset = appIconSize.width * _kAppIconMaxScale / 2;

    switch(quarter) {
      case 0 : return Offset(-appIconOffset, appIconOffset + 10);
      case 1: return Offset(appIconOffset, appIconOffset + 10);
      case 2: return Offset(-appIconOffset, -appIconOffset - 10);
      case 3: return Offset(appIconOffset, -appIconOffset - 10);
    }

    return Offset.zero;
  }

  int _calculateQuarter() {
    final appIconSize = widget.layerLink.leaderSize ?? Size.zero;

    final offset = widget.appPosition + Offset(appIconSize.width / 2, appIconSize.height / 2);
    final screenSize = MediaQuery.of(context).size;

    final center = Offset(screenSize.width / 2, screenSize.height / 2);

    if(offset.dy < center.dy) {
      if(offset.dx < center.dx) return 0;
      if(offset.dx >= center.dx) return 1;
    } else {
      if(offset.dx < center.dx) return 2;
      if(offset.dx >= center.dx) return 3;
    }

    return 0;
  }
}

const _kDynamicBlurMaxValue = 10;

class _DynamicBlur extends StatelessWidget {
  const _DynamicBlur({
    Key? key,
    required this.blurAnimation,
  }) : super(key: key);

  final Animation<double> blurAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: blurAnimation,
      builder: (context, child) {
        final sigma = blurAnimation.value * _kDynamicBlurMaxValue;
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: sigma,
            sigmaY: sigma,
          ),
          child: child,
        );
      },
      child: const SizedBox.expand(),
    );
  }
}
