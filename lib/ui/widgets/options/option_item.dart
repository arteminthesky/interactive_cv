import 'package:app_base/app_base.dart';
import 'package:flutter/cupertino.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({
    Key? key,
    required this.option,
    this.onClick,
  }) : super(key: key);

  final Option option;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenuAction(
      child: Text(
        option.name(context),
      ),
      onPressed: () {
        option.onClick(context);
        onClick?.call();
      },
    );
  }
}
