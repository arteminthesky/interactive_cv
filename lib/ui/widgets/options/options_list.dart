import 'package:app_base/app_base.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:interactive_cv/ui/widgets/options/option_item.dart';

const _kDividerColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFFA9A9AF),
  darkColor: Color(0xFF57585A),
);

class OptionsList extends StatelessWidget {
  const OptionsList({
    Key? key,
    required this.options,
    required this.sizeTransition,
    required this.onItemClicked,
  }) : super(key: key);

  final List<Option> options;
  final Animation<double> sizeTransition;
  final VoidCallback onItemClicked;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: ClipSmoothRect(
        radius: SmoothBorderRadius(
          cornerRadius: 10,
          cornerSmoothing: 0.5,
        ),
        child: SizeTransition(
          sizeFactor: sizeTransition,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              OptionItem(
                option: options.first,
                onClick: onItemClicked,
              ),
              for (var option in options.skip(1))
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: CupertinoDynamicColor.resolve(
                            _kDividerColor, context),
                        width: 0.5,
                      ),
                    ),
                  ),
                  position: DecorationPosition.foreground,
                  child: OptionItem(
                    option: option,
                    onClick: onItemClicked,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
